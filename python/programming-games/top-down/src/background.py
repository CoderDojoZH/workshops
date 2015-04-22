import pygame
from pygame.locals import *


class Background:
    def __init__(self):
        self._background = None
        self._tiles = None

    def init(self):
        self._background = pygame.image.load("../img/terrain_4.png").convert()
        self._tiles = [[0 for x in range(15)] for x in range(20)]
        for i in range(0, 20):
            for j in range(0, 15):
                self._tiles[i][j] = 1

    def render(self, display):
        for i in range(0, 20):
            for j in range(0, 15):
                x = self._tiles[i][j] * 32
                display.blit(self._background, (i * 32, j * 32), (x, 0, x + 32, 32))

    def update(self, ft):
        pass
