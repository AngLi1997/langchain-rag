import gradio
from gradio.components.clear_button import ClearButton
from gradio.components.textbox import Textbox
from langchain_ollama import ChatOllama

llm = ChatOllama(model="deepseek-r1:32b", base_url="http://192.168.110.129:11434")

if __name__ == '__main__':
    with gradio.Blocks() as demo:
        chatbot = gradio.Chatbot(type="messages")
        input_box = Textbox(label="请输入问题", placeholder="Enter text and press enter")
        def chat(message, history):
            history.append({"role": "user", "content": message})
            chunks = llm.stream(input=history)
            resp = {}
            for chunk in chunks:
                print(chunk.content)
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
        clear = ClearButton([chatbot, input_box])
    demo.launch()