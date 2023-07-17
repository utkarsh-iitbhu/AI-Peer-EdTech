# import speech_recognition as sr
# import webbrowser
# r1 = sr.Recognizer()
# print('Now speak : ')
# q = ""
# with sr.Microphone() as source:
#     # Timeout is the allowed time to speak
#     audio = r1.listen(source , timeout=3)
#     query = r1.recognize_google(audio,language='eng-in')
#     # print(query)
#     q += query
#     # Error metric: WER Word error rate (WER) is a common metric of the performance of an automatic speech recognition system.

# with open("aud_text.txt", "w") as file:
#     file.write(q)
    
    
import speech_recognition as sr
print(sr.__version__)
r = sr.Recognizer()

file_audio = sr.AudioFile('U:\Inter_IIT_Startup_Stardom\Startup_Stardom\2U.mp3')

with file_audio as source:
   audio_text = r.record(source)

print(type(audio_text))
print(r.recognize_google(audio_text))



