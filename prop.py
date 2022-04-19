class Prop:
	
	def __init__(self, *args):
		self.id = ''
		self.type = ''
		self.creature = ''
		self.param01 = ''
		self.param02 = ''
		self.state = ''
		self.interactions = []

		
		if len(args) == 5: 
			if type(args[2]) is bool:
				# pour les chemins
				self.id = args[0]
				self.type = args[1]
				self.state = args[2]
				self.param01 = args[3] #scene1
				self.param02 = args[4] #scene2
			else:
				#pour les créatures
				self.id = args[0]
				self.type = args[1]
				self.creature = args[2]
				self.param01 = args[3] #scene
				self.param02 = args[4] #unlock
		elif len(args) == 4: # pour les objets
			self.id = args[0]
			self.type = args[1]
			self.param01 = args[2] #scene
			self.param02 = args[3] #unlock
		
		
	def getID(self):
		return self.id
	
	def getType(self):
		return self.type

	def getCreature(self):
		return self.creature
	
	def getState(self):
		return self.state
	
	def getParam01(self):
		return self.param01
	
	def getParam02(self):
		return self.param02
	
	def getInteractions(self):
		return self.interactions
	
	def addInteraction(self,action):
		self.interactions.append(action)
		
	def openProp(self):
		if (self.state == False):
			self.state = True
