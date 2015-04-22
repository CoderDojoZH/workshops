import pygame
from pygame.locals import *


class Background:
    def __init__(self):
        self._background = None
        self._tiles = None

    def init(self):
        self._background = pygame.image.load("../img/sum.png").convert()
        self._tiles = [[0 for x in range(10)] for x in range(10)]
        for i in range(0, 10):
            for j in range(0, 10):
                self._tiles[i][j] = 1

    def render(self, display):
        for i in range(0, 10):
            for j in range(0, 10):
                x = self._tiles[i][j] * 60
                display.blit(self._background, (i * 50, j * 50), (x, 0, x + 60, 60))

    def update(self, ft):
        pass
