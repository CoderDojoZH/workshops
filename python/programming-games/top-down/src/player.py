import pygame
from pygame.locals import *
from object import Object

class Player(Object):
    def __init__(self):
        self._image = None
        self._x = 0
        self._y = 0
        self._direction = -1

    def setDirection(self, dir):
        self._direction = dir

    def init(self):
        self._image = pygame.image.load("../img/units_red.png").convert()

    def render(self, display):
        display.blit(self._image, (self._x, self._y), (0, 0, 32, 32))

    def update(self, ft):
        if self._direction == 0:
            self._y += ft * 10
        if self._direction == 1:
            self._x += ft * 10
        if self._direction == 2:
            self._y -= ft * 10
        if self._direction == 3:
            self._x -= ft * 10
