import os

from langchain_core.tools import Tool
from langchain_google_community import GoogleSearchAPIWrapper

os.environ["GOOGLE_CSE_ID"] = "c63c6b0c20f294844"
os.environ["GOOGLE_API_KEY"] = "AIzaSyCa1WQjRre9rnp65D_m0wjUqaPguFsuzDc"

def google_search(query):
    return GoogleSearchAPIWrapper().results(query, 5)

tool = Tool(name="Google Search", description="Search Google for recent results.", func=google_search)

for res in tool.invoke("林俊杰的新歌有哪些"):
    print(res)