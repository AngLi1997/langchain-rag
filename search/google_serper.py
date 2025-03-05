import os
import pprint

from langchain_community.utilities import GoogleSerperAPIWrapper

os.environ["SERPER_API_KEY"] = "165d4285a70a571a0659b3bda8cd61da7c273f18"

search = GoogleSerperAPIWrapper(gl="cn", hl="zh-CN")

results = search.run("林俊杰的新歌有哪些")

pprint.pp(results)