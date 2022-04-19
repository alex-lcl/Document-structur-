class Player:
	id=''
	currentScene=''

	def __init__(self, idPlayer):
		self.id = idPlayer

	def getID(self):
		return self.id

	def getCurrentScene(self):
		return self.currentScene

	def setCurrentScene(self, newScene):
		self.currentScene = newScene