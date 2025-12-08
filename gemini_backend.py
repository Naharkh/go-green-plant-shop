import os
from flask import Flask, request, jsonify
from google import genai
from werkzeug.utils import secure_filename

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'uploads/'

# Make sure the uploads folder exists
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)

genai_client = genai.Client()

@app.route('/analyze', methods=['POST'])
def analyze():
    if 'image' not in request.files:
        return jsonify({'error': 'No image uploaded'}), 400
    image = request.files['image']
    filename = secure_filename(image.filename)
    filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
    image.save(filepath)

    # Call Gemini API (replace with your actual logic)
    response = genai_client.models.generate_content(
        model="gemini-2.5-flash",
        contents=f"Analyze this plant image: {filepath}"
    )
    # For demo, just return the response text
    return jsonify({
        'recommendation': response.text,
        'plants': []  # You can parse and format plant recommendations here
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
