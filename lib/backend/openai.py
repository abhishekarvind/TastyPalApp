from flask import Flask, request, jsonify
import openai
import requests

app = Flask(__name__)

# Initialize global variables
generated_content = None
response = None

def get_completion(prompt):
    headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer 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"
    }

    data = {
        "model": "gpt-3.5-turbo-instruct",
        "prompt": prompt,
        "max_tokens": 600,
        "temperature": 0.5
    }

    response = requests.post("https://api.openai.com/v1/completions", headers=headers, json=data)

    if response.status_code == 200:
        return response.json()
    else:
        print(f"Error: {response.status_code}")
        return None

@app.route('/get_openai_response', methods=['POST', 'GET'])
def get_openai_response():
    global generated_content
    global response

    try:
        if request.method == "POST":
            data = request.json
            prompt = data.get('prompt', '')
            response = get_completion(prompt)

            if response:
                generated_content = response['choices'][0]['text']
                return jsonify({'generated_content': generated_content})

        if request.method == "GET":
            if generated_content:
                return jsonify({'generated_content': generated_content})
            else:
                return jsonify({'error': 'No response available'})

    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
