# !pip install -U spacy
# !python -m spacy download en_core_web_sm

import spacy
from spacy.lang.en.stop_words import STOP_WORDS
from string import punctuation as pun
from heapq import nlargest
stopwords = list(STOP_WORDS)
nlp = spacy.load('en_core_web_sm')

with open('input_for_summary.txt') as f:
    text = f.read()


# doc = nlp(text)
def summmary_generator(text):
    doc = nlp(text)
    tokens = [token.text for token in doc]
    # print(tokens)
    punctuation = pun + '\n'
    # punctuation
    word_frequencies = {}
    for word in doc:
        if word.text.lower() not in stopwords:
            if word.text.lower() not in punctuation:
                if word.text not in word_frequencies.keys():
                    word_frequencies[word.text] = 1
        else:
            if word.text in word_frequencies:
                word_frequencies[word.text] += 1
    # print(word_frequencies)

    max_frequency = max(word_frequencies.values())
    max_frequency
    for word in word_frequencies.keys():
        word_frequencies[word] = word_frequencies[word]/max_frequency
    # print(word_frequencies)
    sentence_tokens = [sent for sent in doc.sents]
    # print(sentence_tokens)

    sentence_scores = {}
    for sent in sentence_tokens:
        for word in sent:
            if word.text.lower() in word_frequencies.keys():
                if sent not in sentence_scores.keys():
                    sentence_scores[sent] = word_frequencies[word.text.lower()]
                else:
                    sentence_scores[sent] += word_frequencies[word.text.lower()]
    sentence_scores

    
    select_length = int(len(sentence_tokens)*0.3)
    select_length
    summary = nlargest(select_length, sentence_scores, key = sentence_scores.get)
    summary
    final_summary = [word.text for word in summary]
    summary = ' '.join(final_summary)
    # flashcards = [summary.split("\n") for summary in summary]
    
    return summary

# with open("summary_text.txt", "w") as file:
#     file.write(summary)
