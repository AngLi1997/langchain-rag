import gradio
from gradio import Textbox
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

# for msg, event in graph.stream({"messages": [{"role": "user", "content": "1+1在什么情况下等于3"}]}, stream_mode="messages"):
#     print(msg.content, end="")


if __name__ == '__main__':
    with gradio.Blocks() as demo:
        chatbot = gradio.Chatbot(type="messages")
        input_box = Textbox(label="请输入问题", placeholder="Enter text and press enter")
        def chat(message, history):
            history.append({"role": "user", "content": message})
            chunks = graph.stream({"messages": history}, stream_mode="messages")
            resp = {}
            for chunk, event in chunks:
                if chunk.content == "<think>":
                    resp = {"role": "assistant", "content": "", "metadata": {"title":"thinking"}}
                    history.append(resp)
                elif chunk.content == "</think>":
                    resp = {"role": "assistant", "content": ""}
                    history.append(resp)
                else:
                    resp["content"] += chunk.content
                yield "", history
        input_box.submit(chat, [input_box, chatbot], [input_box, chatbot])
    demo.launch()