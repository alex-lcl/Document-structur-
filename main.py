from player import Player
from interaction import Interaction
from prop import Prop
from scene import Scene
from world import World


global player
global scene
global world
world = World()
player = world.getPlayer()


def validate():
	from lxml import etree
	fichier = "FR_Alexandra.xml"
	parser = etree.XMLParser(dtd_validation=True)
	try:
		global valid 
		valid = etree.parse(fichier, parser=parser)
		return "Le document XML est bien formé et valide."
	except etree.XMLSyntaxError as error:
		return error

def load():
	
	#PLAYER
	#On récupère tous les éléments player dans une liste
	nodeList = valid.findall('//player')
	#On parcourt la liste pour récupérer la valeur de CurrentScene que l'on ajoute à l'objet player
	for element in nodeList:
		attrList=element.items()
		player.setCurrentScene(attrList[0][1])

	#SCENE
	#On récupère tous les éléments scene dans une liste
	nodeList = valid.findall('//scene')
	id = None
	numPath = 0
	numObjects = 0
	numCreature = 0
	msj = None
			
	#On parcourt la liste
	for element in nodeList:
	#Pour chaque élément de la liste, on récupère sa liste d'attributs
		attrList = element.items()
	#On récupère la valeur des attributs que l'on assigne à l'objet scene
		for attr in attrList: #id, numPath, numObjects, numCreature, msj
			if attr[0] == "id":
				id = attr[1]
			elif attr[0] == "msj":
				msj = attr[1]
			elif attr[0] == "numObjects":
				numObjects = attr[1]
			elif attr[0] == "numPath":
				numPath = attr[1]
			elif attr [0] == "numCreature":
				numCreature = attr[1]
		scene = Scene(id, numPath, numObjects, numCreature, msj)
	
	#SCENE ACTIONS
	#On récupère tous les éléments action dans une liste
		actionList = element.findall('.//action')
		dest = None
		msj_action = None
	#On parcourt la liste
		for action in actionList:
	#Pour chaque élément de la liste, on récupère sa liste d'attributs
			attrList =  action.items()
	#On parcourt cette liste pour créer un objet Interaction que l'on ajoute à l'objet Scene avec la méthode désignée.
			for attr in attrList:
				if attr[0] == "dest":
					dest = attr[1]
				if attr[0] == "msj":
					msj_action=attr[1]
			
			scene.addInteraction(Interaction(dest, msj_action))
	
		world.addScene(scene)
	
	#PROPS
	#On récupère tous les éléments props dans une liste
	nodeList = valid.findall('//prop')
	id = None
	kind = None
	state = None
	creature = None
	param01 = None
	param02 = None
	#On parcourt la liste
	for element in nodeList:
	#Pour chaque élément de la liste, on récupère sa liste d'attributs
		attrList = element.items()
	#On récupère la valeur des attributs que l'on assigne à l'objet prop correspondant :
		for attr in attrList:
			if attr[0] == "id":
				id = attr[1]
			elif attr[0] == "kind":
				kind = attr[1]
			elif attr[0] == "state":
				if attr[1] == "True":
					state = True
				elif attr[1] == "False":
					state = False
			elif attr[0] == "scene01":
				param01 = attr[1]
			elif attr[0] == "scene02":
				param02 = attr[1]
			elif attr[0] == "unlock":
				param02 = attr[1]
			elif attr[0] == "creature":
				creature = attr[1]

		if(kind == "path"):
			prop = Prop(id, kind, state, param01, param02)
		elif(kind == "object"):
			prop = Prop(id, kind, param01, param02)
		elif (kind == "beeing"):
			prop = Prop(id, kind, creature, param01, param02)
		else:
			break
	
	#PROPS ACTIONS
	#On récupère tous les éléments action dans une liste
		actionList = element.findall(".//action")
	#On parcourt la liste
		for action in actionList:
	#Pour chaque élément de la liste, on récupère sa liste d'attributs
			attrList = action.items()
			condition = None
			msj_action = None
	#On parcourt cette liste pour créer un objet Interaction que l'on ajoute à l'objet prop avec la méthode désignée.
			for attr in attrList:
				if attr[0] == "condition":
					condition = attr[1]
				if attr[0] == "msj":
					msj_action = attr[1]
			prop.addInteraction(Interaction(condition, msj_action))
		
		scene = world.getScene(param01)
		scene.addProp(prop)
		
		if(kind == "path" and param01 != param02):
			scene = world.getScene(param02)
			scene.addProp(prop)

def readInput(options):
	rep = input()
	try:
		answer = int(rep)
		if((answer < 0) or (answer > options)):
			raise Exception("Veuillez choisir un numéro dans la liste.")
		return answer-1
	except:
		print("Veuillez entrer un numéro de réponse valide.")
		return readInput(options)

def startGame(info):

	scene = world.getScene(player.getCurrentScene())
	nextScene = True
	msj = scene.getDescription()
	interactions = scene.getInteractions()
	
	if(info):
		print("----------------------------------------------")
		print(msj)
		for i in range(len(interactions)):
			print("  " , i+1 , ". ", interactions[i].getDescription())
	
	answer = readInput(len(interactions))
	
	dest = interactions[answer].getVariable()
	prop = scene.getProp(dest)

	kind = prop.getType()
	state = prop.getState()
	param01 = prop.getParam01()
	param02 = prop.getParam02()
	interactions = prop.getInteractions()
	
	if(kind == "path"):
		if(state is True):
			msj = "open"
			print(msj)
			info = True
			if(player.getCurrentScene() == param01):
				if(param02 == param01):
					info = False
				else:
					if(param02 == "final"):
						nextScene = False
					player.setCurrentScene(param02)
			elif(player.getCurrentScene() == param02):
				if(param01 == param02):
					info = False
				else:
					if(param01 == "final"):
						nextScene = False
					player.setCurrentScene(param01)
		else:
			msj = "closed"
			info = False
		for i in range(len(interactions)):
			if(interactions[i].getVariable() == msj):
				msj = interactions[i].getDescription()
				break
	elif(kind == "object") or (kind == "beeing"):
		prop = world.getProp(param02)
		if (prop != None):
			prop.openProp()
		msj = interactions[0].getDescription()
		info = False
	print(msj)
	if(nextScene):
		startGame(info)
	else:
		print(world.getScene(player.getCurrentScene()).getDescription())

def main():
	validate()
	load()
	startGame(True)

main()