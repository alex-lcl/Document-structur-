from player import Player
from prop import Prop

class World:

	scenes = []
	
	def __init__(self):
		global player 
		self.player = Player("player00")

	def getPlayer(self):
		print(self.player)
		return self.player
	
	def addScene(self, newScene):
		self.scenes.append(newScene)
		
	def removeScene(self, idScene):
		self.scenes.remove(self.getScene(idScene))

	def getScene(self, idScene):
		for i in range(len(self.scenes)):
			if self.scenes[i].getID() == idScene :
				return self.scenes[i]
		return None
	
	def getProp(self, idProp):
		prop = Prop()
		for i in range(len(self.scenes)):
			prop = self.scenes[i].getProp(idProp)
			if(prop != None) :
				return prop
		return None