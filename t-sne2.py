#!/usr/bin/env python3
"""
Author      : Yukun Feng
Date        : 2018/07/23
Email       : yukunfg@gmail.com
Description : T-SNE to visualize word vectors
"""

import random
import numpy as np
import matplotlib.pyplot as plt
plt.switch_backend('agg')
import matplotlib.cm as cm
from sklearn.manifold import TSNE
import word2vec


class TSNEWrapper(object):
    """TSNE to visualize vectors"""
    def __init__(self, corpus_path, cluster_path):
        """init"""
        self.corpus_path = corpus_path
        self.freq_word_count = 2000
        self.cluster_count = 15
        self.load_cluster(cluster_path)
        self.colors = cm.rainbow(np.linspace(0, 1, len(self.clusters)))

    def load_cluster(self, cluster_path):
        from collections import Counter
        counter = Counter()
        lines = [
            counter.update(line.strip().split())
            for line in open(self.corpus_path, 'r').readlines()
        ]

        fh = open(cluster_path, "r")
        self.word2cluster = {}
        self.cluster2word = {}
        freq_cluster_tag = "600"
        self.freq_cluster_tag = freq_cluster_tag
        for line in fh:
            line = line.strip()
            # Skip empty lines
            if line == "":
                continue
            word, cluster = line.split()
            if word in counter and counter[word] >= 100:
                cluster = freq_cluster_tag
            self.word2cluster[word] = cluster
            if cluster not in self.cluster2word:
                self.cluster2word[cluster] = []
            self.cluster2word[cluster].append(word)
        fh.close()
        self.clusters = list(self.cluster2word.keys())
        random.shuffle(self.clusters)
        self.clusters = self.clusters[0:self.cluster_count]

        if freq_cluster_tag not in self.clusters:
            self.clusters.append(freq_cluster_tag)
        random.shuffle(self.cluster2word[freq_cluster_tag])
        self.cluster2word[freq_cluster_tag] = self.cluster2word[freq_cluster_tag][0:self.freq_word_count]

        self.all_words = []
        for cluster in self.clusters:
            words = self.cluster2word[cluster]
            for word in words:
                self.all_words.append(word)


    def savefig(self, outfile, word_vec_path, before_finue=True):
        self.model = word2vec.load(word_vec_path, kind="txt")
        indexs = np.arange(0, self.model.vectors.shape[0], dtype=int)
        words = self.model.vocab[indexs]
        word2index = {}
        for word, index in zip(words, indexs):
            word2index[word] = index

        vectors = []
        count = 0
        reduced_word2index = {}
        for word in self.all_words:
            if word not in word2index:
                continue
            index = word2index[word]
            vector = self.model.vectors[index]
            vectors.append(vector)
            reduced_word2index[word] = count
            count += 1

        vectors = np.array(vectors)

        tsne = TSNE(n_components=2, random_state=0)
        embeddings_en_2d = tsne.fit_transform(vectors)

        plt.figure(figsize=(16, 9))
        for cluster, color in zip(self.clusters, self.colors):
            words = self.cluster2word[cluster]
            cluster_embedings = []
            for word in words:
                if word in reduced_word2index:
                    index = reduced_word2index[word]
                    vector = embeddings_en_2d[index]
                    cluster_embedings.append(vector)
            cluster_embedings = np.array(cluster_embedings)
            x = cluster_embedings[:, 0]
            y = cluster_embedings[:, 1]
            cluster_label = f"cluster-{cluster}"
            if before_finue and cluster != self.freq_cluster_tag:
                plt.scatter(x[0], y[0], c=color, alpha=0.7, label=cluster, s=22**2)
                plt.annotate(cluster_label, alpha=0.5, xy=(x[0], y[0]), xytext=(5, 2),
                             textcoords='offset points', ha='right', va='bottom', size=8)
            else:
                plt.scatter(x, y, c=color, alpha=0.7, label=cluster)
                if cluster != self.freq_cluster_tag:
                    plt.annotate(cluster_label, alpha=0.5, xy=(x[0], y[0]), xytext=(5, 2),
                                 textcoords='offset points', ha='right', va='bottom', size=8)
            #  for i, word in enumerate(words):
                #  plt.annotate(self.word2cluster[word], alpha=0.5, xy=(x[i], y[i]), xytext=(5, 2),
                             #  textcoords='offset points', ha='right', va='bottom', size=8)
            print(f"now finish processing {cluster}")
        plt.savefig(outfile)


    def show_n_vectors(self, number):
        """show first n vectors in the word2vec model"""
        vectors = self.model.vectors[0:number]
        indexs = np.arange(0, number, dtype=int)
        words = self.model.vocab[indexs]
        self.show(vectors, words)

    def show(self, vectors, words):
        """show
        """
        tsne = TSNE(n_components=2, random_state=0)
        np.set_printoptions(suppress=True)
        Y = tsne.fit_transform(vectors)

        plt.scatter(Y[:, 0], Y[:, 1])
        for label, x, y in zip(words, Y[:, 0], Y[:, 1]):
            plt.annotate(
                label, xy=(x, y),
                xytext=(0, 0), textcoords='offset points'
            )
        #  plt.show()
        plt.savefig('foo.pdf')
        

if __name__ == '__main__':
    # Unit test
    #  word_vec_path = "../common_corpus/data/50lm/en/train.txt.200.cbow.e5.catcl.600.neg5.ns.nosub"
    word_vec_path = "../common_corpus/data/50lm/en/train.txt.200.w100.c100.o100.cbow.e5.catcl.600.neg5.ns.nosub"
    corpus_path = "../common_corpus/data/50lm/en/train.txt"
    cluster_path = "../common_corpus/data/50lm/en/train.txt.cluster.600"
    tnse = TSNEWrapper(corpus_path, cluster_path)
    #  tnse.show_n_vectors(200)
    tnse.savefig("./foo.pdf", word_vec_path)
    word_vec_path = "../common_corpus/data/50lm/en/after_finue.vec"
    tnse.savefig("./foo2.pdf", word_vec_path, before_finue=False)

    word_vec_path = "../common_corpus/data/50lm/en/after_finue_nocluster.vec"
    tnse.savefig("./foo3.pdf", word_vec_path, before_finue=False)
