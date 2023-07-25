from flask import Flask, request, jsonify
import joblib

app = Flask(__name__)

model = joblib.load('Modelo/modelo_svm.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    try:

        data = request.get_json(force=True)
        
        prediction = model.predict([data['feature']])

        return jsonify({'prediction': prediction.tolist()})
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(debug=True)
