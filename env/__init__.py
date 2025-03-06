import os

def set_default_env():
    os.environ["LANGSMITH_TRACING"] = "true"
    os.environ["LANGSMITH_ENDPOINT"] = "https://api.smith.langchain.com"
    os.environ["LANGSMITH_PROJECT"] = "liang-lang-smith"
    os.environ["LANGSMITH_API_KEY"] = "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"
    os.environ["SERPER_API_KEY"] = "165d4285a70a571a0659b3bda8cd61da7c273f18"