from langchain_text_splitters import RecursiveCharacterTextSplitter

spliter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=200)

if __name__ == '__main__':
    with open("/Users/liang/Desktop/knowledge/prd/001_2-记录配置_审批.md") as file:
        text = file.read()
        chunks = spliter.split_text(text)
        i = 0
        for chunk in chunks:
            print(f'----------------{i}----------------')
            print(chunk)
            print(f'----------------{i}----------------')
            i += 1
