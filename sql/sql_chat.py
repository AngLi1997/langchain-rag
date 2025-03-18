from langchain_ollama import ChatOllama

deepseek = ChatOllama(model="deepseek-r1:32b", base_url="http://192.168.110.129:11434")

if __name__ == '__main__':
    for chunk in deepseek.stream([{"role": "user", "content": "使用静态html和js实现一个贪吃蛇小游戏，要求直接就能执行， 写在一个html文件里，直接告诉我文件的内容"}]):
        print(chunk.content, end="")
