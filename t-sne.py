#!/usr/bin/env python3
"""
Author      : Yukun Feng
Date        : 2018/07/23
Email       : yukunfg@gmail.com
Description : T-SNE to visualize word vectors
"""

import numpy as np
import matplotlib.pyplot as plt
from sklearn.manifold import TSNE
import word2vec


class TSNEWrapper(object):
    """TSNE to visualize vectors"""
    def __init__(self, file_name):
        """init"""
        self.model = word2vec.load(file_name)

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
        plt.show()
        

if __name__ == '__main__':
    # Unit test
    tnse = TSNEWrapper("../common_corpus/text8.bin")
    tnse.show_n_vectors(1000)
