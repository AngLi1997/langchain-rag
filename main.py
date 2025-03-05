import os

import gradio
from gradio import Textbox
from langchain_community.utilities import GoogleSerperAPIWrapper
from langchain_core.tools import Tool
from langchain_ollama import ChatOllama
from langgraph.constants import START, END
from langgraph.graph import add_messages, StateGraph
from langgraph.prebuilt import ToolNode, tools_condition
from typing_extensions import TypedDict, Annotated

os.environ["LANGSMITH_TRACING"] = "true"
os.environ["LANGSMITH_ENDPOINT"] = "https://api.smith.langchain.com"
os.environ["LANGSMITH_PROJECT"] = "liang-lang-smith"
os.environ["LANGSMITH_API_KEY"] = "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"
os.environ["SERPER_API_KEY"] = "165d4285a70a571a0659b3bda8cd61da7c273f18"

llm = ChatOllama(model="llama3.1:latest", base_url="http://192.168.110.129:11434")
search = GoogleSerperAPIWrapper()
tools = [Tool(name="google search", func=search.results, description="google search")]
llm_with_tools = llm.bind_tools(tools)

class State(TypedDict):
    messages: Annotated[list, add_messages]


def chatbot(state: State):
    res = ""
    for chunk in llm_with_tools.stream(state["messages"]):
        res += chunk.content
        yield {"messages": res}


workflow = StateGraph(State)

workflow.add_node("chatbot", chatbot)
workflow.add_node("tools", ToolNode(tools=tools))
# graph_builder.add_conditional_edges("chatbot", tools_condition)
workflow.add_edge("tools", "chatbot")

workflow.add_edge(START, "tools")
workflow.add_edge("chatbot", END)

graph = workflow.compile()

print(graph.get_graph().draw_ascii())

if __name__ == '__main__':
    with gradio.Blocks(title="langgraph-deepseek") as demo:
        chatbot = gradio.Chatbot(type="messages")
        input_box = Textbox(label="请输入问题", placeholder="Enter text and press enter")
        def chat(message, history):
            history.append({"role": "user", "content": message})
            chunks = graph.stream({"messages": history}, stream_mode="messages")
            # resp = {}
            resp = {"role": "assistant", "content": ""}
            history.append(resp)
            for chunk, event in chunks:
                # if chunk.content == "<think>":
                #     resp = {"role": "assistant", "content": "", "metadata": {"title":"thinking"}}
                #     history.append(resp)
                # elif chunk.content == "</think>":
                #     resp = {"role": "assistant", "content": ""}
                #     history.append(resp)
                # else:
                print(chunk.content, end="")
                resp["content"] += chunk.content
                yield "", history
        input_box.submit(chat, [input_box, chatbot], [input_box, chatbot])
    demo.launch()