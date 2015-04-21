import pygame
from pygame.locals import *


class Background:
    def __init__(self):
        self._background = None

    def init(self):
        self._background = pygame.image.load("../img/back2.png").convert()

    def render(self, display):
        for i in range(0, 10):
            for j in range(0, 10):
                display.blit(self._background, (i * 50, j * 50))

    def update(self, ft):
        pass
