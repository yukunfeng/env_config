import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.functional as F
import word2vec
from collections import Counter

x = torch.tensor([[0.1, 1.2], [2.2, 3.1], [4.9, 5.2]], requires_grad=True, device="cpu")
y = torch.randint(0, 5, (2, 3, 4))
#  model = word2vec.load("/home/lr/yukun/common_corpus/data/50lm/penn/train.txt.200.skipgram.e5.neg5.ns.uword0.sub.vec", kind="txt")
model = word2vec.load("/home/lr/yukun/common_corpus/data/50lm/en/vocab_embs/lm.bilstm.no_pretrain.emb", kind="txt")
#  model = word2vec.load("/home/lr/yukun/common_corpus/data/50lm/en/vocab_embs/lm.bilstm.outemb", kind="txt")
#  model = word2vec.load("/home/lr/yukun/common_corpus/data/50lm/en/lm.bilstm.has_pretrain.emb", kind="txt")

data_path = "/home/lr/yukun/common_corpus/data/50lm/en/train.txt"
counter = Counter()
lines = [
    counter.update(line.strip().split())
    for line in open(data_path, 'r').readlines()
]

#  words = "man including relatively unconditional hydroplane"
words = "man including relatively Richard car"
close_words_map = {}
close_words_map["man"] = "person anyone children men"
close_words_map["including"] = "like featuring"
close_words_map["relatively"] = "extremely very quite"
close_words_map["Richard"] = "Jonathan Robert Neil Nancy"
close_words_map["car"] = "automobile"

words = words.split()
for word in words:
    indexes, metrics = model.similar(word, 30)
    print(f"word:{word}")
    print(model.vocab[indexes])
    print(model.vocab[model.similar(word, 30)[0]])
    list_words = list(model.vocab[model.similar(word, 20000)[0]])
    close_words = close_words_map[word].split()
    for close_word in close_words:
        index = list_words.index(close_word)
        print(f"{word}-{counter[word]} {close_word}-{counter[close_word]}, index: {index}")
        print(model.distance(word, close_word))
        
    print("------")
