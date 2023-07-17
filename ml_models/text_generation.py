# from transformers import pipeline
# generator = pipeline('text-generation', model='EleutherAI/gpt-neo-1.3B')
# prompt = 'Mitochondria explain'
# res = generator(prompt, max_length=10, do_sample=True, temperature=0.9)
# print("Generated text : "+res[0]['generated_text'])

import openai
import re
from api_key import API_KEY

openai.api_key = API_KEY

# Set the model to use
# model_engine = "text-davinci-003"

# Set the prompt to generate text for
# text = input("What topic you want to write about: ")
# prompt = text


def generate_text(prompt):
    # print("The AI BOT is trying now to generate a new text for you...")
    # Generate text using the GPT-3 model
    model_engine = "text-davinci-003"
    completions = openai.Completion.create(
        engine=model_engine,
        prompt=prompt,
        max_tokens=1024,
        n=1,
        stop=None,
        temperature=0.5,
    )

    # Print the generated text
    generated_text = completions.choices[0].text
    return generated_text

# Save the text in a file
# with open("generated_text.txt", "w") as file:
#     file.write(generated_text.strip())

# print("The Text Has Been Generated Successfully!")