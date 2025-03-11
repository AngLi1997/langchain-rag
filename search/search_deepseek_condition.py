import re
from typing import TypedDict, List, Annotated, Literal

from langchain_community.utilities import GoogleSerperAPIWrapper
from langchain_ollama import ChatOllama
from langgraph.checkpoint.memory import MemorySaver
from langgraph.constants import END, START
from langgraph.graph import StateGraph, add_messages
from env import set_default_env

set_default_env()

search = GoogleSerperAPIWrapper(gl="cn", hl="zh-CN")
deepseek = ChatOllama(model="deepseek-r1:32b", base_url="http://192.168.110.129:11434")
memory = MemorySaver()


class GraphStateNode(TypedDict):
    query: str
    search_results: List[dict]
    messages: Annotated[list, add_messages]


def search_online_condition(state: GraphStateNode) -> Literal["search", "deepseek"]:
    print(f'联网判断:{state["query"]}')
    result = deepseek.invoke([
        {"role": "user", "content": f'''
            你是一个语义解析模型，你的任务是判断用户问题中包含的信息是否需要联网搜索。
            重要！只能返回 "search" 或 "deepseek"，不要返回其他内容。
            如果用户问题中包含的信息需要联网搜索，请返回 "search"，否则返回 "deepseek"。
            用户问题：
                {state["query"]}
        '''}
    ])
    result = re.sub(r'<think>.*?</think>', '', result.content, flags=re.DOTALL).strip()
    print(f'判断结果：{result}')
    if result == "search":
        return "search"
    else:
        return "deepseek"


def search_online(state: GraphStateNode):
    print(f'正在联网搜索: {state["query"]}')
    results = search.results(state["query"])['organic'][:5]
    return {"search_results": results}


def deepseek_node(state: GraphStateNode):
    if state.get("search_results", []):
        print(f'正在结合联网搜索结果deepseek:{state["query"]}')
        state["messages"].append({"role": "user", "content": f'''
            联网搜索结果：
            {state["search_results"]}
            请结合联网搜索结果进行回答问题：
            {state["query"]}
        '''
        })
    else:
        print(f'正在deepseek:{state["query"]}')
        state["messages"].append({"role": "user", "content": f'''
            请不使用联网搜索结果回答问题：
            {state["query"]}
        '''
        })
    result = deepseek.invoke(state["messages"])
    state["messages"].append({"role": "assistant", "content": result.content})
    return {"messages": [], "search_results": []}


workflow = StateGraph(GraphStateNode)

workflow.add_node("deepseek", deepseek_node)
workflow.add_node("search", search_online)

workflow.add_conditional_edges("__start__", search_online_condition)
workflow.add_edge("search", "deepseek")
workflow.add_edge("deepseek", END)
graph = workflow.compile(checkpointer=memory)

print(graph.get_graph().draw_ascii())

if __name__ == '__main__':
    for chunk, config in graph.stream({"query": "1+1在什么情况下等于3"}, {"configurable": {"thread_id": "1"}}, stream_mode="messages"):
        if config["langgraph_node"] == "deepseek":
            print(chunk.content, end="")