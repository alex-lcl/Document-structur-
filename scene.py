class Scene:
	id = ''
	numPaths = 0
	numObjects = 0
	numCreatures = 0
	msj = ''

	def __init__(self, idScene, paths, objects, creatures, desc):
		self.interactions = []
		self.props =[]
		self.id = idScene
		self.numPaths = paths
		self.numObjects = objects
		self.numCreatures = creatures
		self.msj = desc
		
	def getID(self):
		return self.id
	
	def getNumPaths(self):
		return self.numPaths
	
	def getNumObjects(self):
		return self.numObjects

	def getNumCreatures(self):
		return self.numCreatures
	
	def getDescription(self):
		return self.msj
	
	def getInteractions(self):
		return self.interactions
	
	def getProps(self):
		return self.props
	
	def addInteraction(self, action):
		self.interactions.append(action)
	
	def addProp(self, newProp):
		self.props.append(newProp)
	
	def removeProp(self, idProp):
		self.props.remove(self.getProp(idProp))
	
	def getProp(self, idProp):
		for i in range(len(self.props)):
			if self.props[i].getID() == idProp :
				return self.props[i]
		return None