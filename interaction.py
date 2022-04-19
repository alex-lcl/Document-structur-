class Interaction:
	variable = ''
	msj = ''

	def __init__(self, var, desc):
		self.variable = var
		self.msj = desc

	def getVariable(self):
		return self.variable

	def getDescription(self):
		return self.msj