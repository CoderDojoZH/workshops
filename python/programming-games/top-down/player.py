import pyglet
import cocos
from object import Object


class Player(Object):
    def __init__(self):
        self._image = None
        self._x = 100
        self._y = 100
        self._v_x = 0

    def init(self):
         self._image = pyglet.resource.image('units_red.png')

    def draw(self):
         self._image.get_region(0, 224 - 32, 32, 32).blit(self._x, self._y, width = 32, height = 32)

    def update(self, ft):
        self._x += self._v_x * ft

    def setXVelocity(self, vx):
        self._v_x = vx


