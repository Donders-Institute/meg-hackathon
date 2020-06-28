import os
from flask import Flask, escape, jsonify, request, Response

app = Flask(__name__)

PORT = int(os.environ.get('PORT')) or 33507

@app.route("/")
def hello():
    name = request.args.get("name", "World")
    print("hello")
    return f'Hello, {escape(name)}!'
    
@app.route('/post', methods = ['POST'])
def postJsonHandler():
    if request.is_json:
        data = request.get_json()
        print(data)
        return 'JSON data posted'
    else:
        return 'no JSON data posted'
    
if __name__ == '__main__':
    app.run(host= '0.0.0.0', port=PORT, debug=True)
