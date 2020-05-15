import json
with open('vmdata.json') as f:
    data = json.load(f)
data1 = json.dumps(data)
print(data1)
data1
