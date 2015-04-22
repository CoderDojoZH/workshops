import pygame
from pygame.locals import *
from object import Object

class Enemy(Object):
    def __init__(self):
        self._image = None
        self._pos = (0, 0)

    def init(self):
        self._image = pygame.image.load("../img/units_blue.png").convert()

    def render(self, display):
        display.blit(self._image, (0, 0), (0, 0, 32, 32))

    def update(self, ft):
        pass
