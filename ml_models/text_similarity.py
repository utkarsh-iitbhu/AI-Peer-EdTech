import numpy as np 
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
# sent1 = input()
# sent2 = input()



with open('similarity1.txt') as f:
    sent1 = f.read()
with open('similarity2.txt') as f:
    sent2 = f.read()

# print(sent1)
# print(sent2)
sen = []
sen.append(sent1)
sen.append(sent2)




def similarity(sen):
    model = SentenceTransformer('bert-base-nli-mean-tokens')
    #Encoding:
    sen_embeddings = model.encode(sen)
    sen_embeddings.shape

    
    #let's calculate cosine similarity for sentence 0:
    simi =  cosine_similarity(
        [sen_embeddings[0]],
        sen_embeddings[1:]
    )
    # print()
    score = str(np.round(simi[0][0]*100,2))
    ans = "Similarity between the sentence is : "+score+"%"
    return ans
    # print("Similarity between the sentect is : "+score+"%")