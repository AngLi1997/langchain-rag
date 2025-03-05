import os
import pprint
from typing import TypedDict, List, Annotated

import gradio
from gradio import Textbox, Chatbot, Checkbox
from langchain_community.utilities import GoogleSerperAPIWrapper
from langchain_ollama import ChatOllama
from langgraph.constants import END
from langgraph.graph import StateGraph, add_messages

os.environ["LANGSMITH_TRACING"] = "true"
os.environ["LANGSMITH_ENDPOINT"] = "https://api.smith.langchain.com"
os.environ["LANGSMITH_PROJECT"] = "liang-lang-smith"
os.environ["LANGSMITH_API_KEY"] = "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"
os.environ["SERPER_API_KEY"] = "165d4285a70a571a0659b3bda8cd61da7c273f18"

search = GoogleSerperAPIWrapper(gl="cn", hl="zh-CN")

deepseek = ChatOllama(model="deepseek-r1:32b", base_url="http://192.168.110.129:11434")


class GraphStateNode(TypedDict):
    query: str
    search_results: List[dict]
    messages: Annotated[list, add_messages]


def search_node(state: GraphStateNode):
    print(f'正在联网搜索: {state["query"]}')
    results = search.results(state["query"])['organic'][:3]
    return {"search_results": results}

def deepseek_node(state: GraphStateNode):
    print(f'联网搜索结果: {state["search_results"]}')
    print(f'用户问题: {state["query"]}')
    prompt = f"""
        你是一个智能助手，可以根据用户的问题结合联网搜索结果进行分析和回答
        请结合联网搜索结果分析和回答用户的问题：
    """
    print(f'正在结合联网搜索结果DeepSeek: {state["query"]}')
    state["messages"].append({"role": "system", "content": f'联网搜索结果：{state["search_results"]}'})
    state["messages"].append({"role": "system", "content": prompt})
    state["messages"].append({"role": "user", "content": state["query"]})
    result = ""
    for _chunk in deepseek.stream(state["messages"]):
        result += _chunk.content
        yield {"messages": result}


workflow = StateGraph(GraphStateNode)
workflow.add_node("search", search_node)
workflow.add_node("deepseek", deepseek_node)
workflow.add_edge("search", "deepseek")
workflow.add_edge("deepseek", END)
workflow.set_entry_point("search")

graph = workflow.compile()

print(graph.get_graph().draw_ascii())


if __name__ == '__main__':
    for msg, chunk in graph.stream({"query": "成都天气怎么样"}, stream_mode="messages"):
        print(msg.content, end="")
    # with gradio.Blocks(title="langgraph-deepseek") as demo:
    #     chatbot = Chatbot(type="messages")
    #     online_switch = Checkbox(label="是否联网搜索", value=True)
    #     input_box = Textbox(label="请输入问题", placeholder="Enter text and press enter")
    #     def chat(message, online, history):
    #         yield "", online, history
    #     input_box.submit(chat, [input_box, online_switch, chatbot], [input_box, online_switch, chatbot])
    # demo.launch()