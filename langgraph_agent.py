import pprint

from langchain_ollama import ChatOllama
from langgraph.constants import START, END
from langgraph.graph import add_messages, StateGraph
from typing_extensions import TypedDict, Annotated

llm = ChatOllama(model="deepseek-r1:32b", base_url="http://192.168.110.129:11434")


class State(TypedDict):
    messages: Annotated[list, add_messages]


def chatbot(state: State):
    res = ""
    for chunk in llm.stream(state["messages"]):
        res += chunk.content
        yield {"messages": res}


graph_builder = StateGraph(State)

graph_builder.add_node("chatbot", chatbot)
graph_builder.add_edge(START, "chatbot")
graph_builder.add_edge("chatbot", END)

graph = graph_builder.compile()

print(graph.get_graph().draw_ascii())

for msg, event in graph.stream({"messages": [{"role": "user", "content": "你好"}]}, stream_mode="messages"):
    print(msg.content, end="")