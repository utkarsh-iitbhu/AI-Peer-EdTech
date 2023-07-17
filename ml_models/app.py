from turtle import color
import pandas as pd
from spacy.lang.en.stop_words import STOP_WORDS
from flask import Flask, request, jsonify, render_template
import spacy
from spacy.lang.en.stop_words import STOP_WORDS
from string import punctuation
from heapq import nlargest
stopwords = list(STOP_WORDS)
nlp = spacy.load('en_core_web_sm')
from text_summary import summmary_generator
import cv2
import numpy as np 

import openai
import re
from api_key import API_KEY
from text_generation import generate_text
import pytesseract

from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
from text_similarity import similarity
from ocr import img_to_str

stopwords = list(STOP_WORDS)

# Create the app object
app = Flask(__name__)


# Define predict function
# @app.route('/')
# def index():
#     return render_template('index.html')


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/summary/',methods=['POST','GET'])
def index1():
    return render_template('summary.html')

@app.route('/predict_summary/',methods=['POST','GET'])
def predict1():
    if request.method == 'POST':
        text = request.form['tweet']
        lis = summmary_generator(text)
        ans = {
            "Text": text,
            "Summary": lis
        }
        return jsonify(ans)
    #Hit predict_summary will give data in this format
        # return render_template('summary.html', pred_summary=jsonify(ans))


@app.route('/generate/',methods=['POST','GET'])
def index2():
    return render_template('generate.html')

'''
    It is a post request and POST request data is in the form of simple TEXT
    Return ans format 
    Thunder client testing API 
'''


@app.route('/predict_gen/',methods=['POST','GET'])
def predict2():
    if request.method == 'POST':
        text = request.form['tweet']
        lis = generate_text(text)
        ans = {
            "Text": text,
            "Generate": lis
        }
        return jsonify(ans)
        # return render_template('generate.html', pred_generate=lis)
        

@app.route('/similarity/',methods=['POST','GET'])
def index3():
    return render_template('similarity.html')

@app.route('/predict_similarity/',methods=['POST','GET'])
def predict3():
    if request.method == 'POST':
        text = request.form['tweet']
        text2 = request.form['tweet2']
        sen = []
        sen.append(text)
        sen.append(text2)
        lis = similarity(sen)
        ans = {
            "Text1": sen[0],
            "Text2": sen[1],
            "Similarity": lis
        }
        return jsonify(ans)
        return render_template('similarity.html', pred_similarity=lis)

@app.route('/audio/',methods=['POST','GET'])
def index4():
    return render_template('audio.html')
import speech_recognition as sr
@app.route('/predict_audio/',methods=['POST','GET'])
def predict4():
    if request.method == 'POST':
        # file = request.files["audio-input"]
        # # read the audio data
        # audio_data = file.read()
        # # create an audio recognizer
        # recognizer = sr.Recognizer()
        # audio = sr.AudioData(audio_data, sample_rate=44100, sample_width=2)
        # # perform speech-to-text on the audio data
        # text = recognizer.recognize_google(audio)
        # return render_template('audio.html', pred_audio=text)
        audio_file = request.files.get("audio_input")
        if not audio_file:
            return jsonify({"error": "audio_file not found"}), 400
        r = sr.Recognizer()
        audio = sr.AudioData(audio_file.read(), sample_rate=44100, 
                            sample_width=2, num_channels=2)
        try:
            text = r.recognize_google(audio)
            return jsonify({"text": text})
        except sr.UnknownValueError:
            return jsonify({"error": "Google Speech Recognition could not understand audio"}), 400
        except sr.RequestError as e:
            return jsonify({"error": "Could not request results from Google Speech Recognition service; {0}".format(e)}), 400


@app.route('/image/',methods=['POST','GET'])
def index5():
    return render_template('image.html')

@app.route('/predict_image/',methods=['POST','GET'])
def predict5():
    if request.method == 'POST':
        file = request.files['image-input']
        # read the image data
        image = cv2.imdecode(np.frombuffer(file.read(), np.uint8), cv2.IMREAD_UNCHANGED)
        # perform OCR on the image
        text = pytesseract.image_to_string(image)
        return render_template('image.html', result=text)


        
if __name__ == "__main__":
    app.run(debug=True)
