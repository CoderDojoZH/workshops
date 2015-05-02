import pyglet
import cocos


class Background:
    def __init__(self):
        self._background = None
        self._tiles = None

    def init(self):
        self._background = pyglet.resource.image('terrain_4.png')
        self._tiles = [[0 for x in range(15)] for x in range(20)]
        for i in range(0, 20):
            for j in range(0, 15):
                self._tiles[i][j] = 1

    def draw(self):
        for i in range(0, 20):
            for j in range(0, 15):
                x = self._tiles[i][j] * 32
                self._background.get_region(x, 320 - 32, 32, 32).blit(i * 32, j * 32, width = 32, height = 32)

    def update(self, ft):
        pass
