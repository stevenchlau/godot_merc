extends Object

var name = ""
var attack = 0
var defense = 0
var counter = 0


func _ready():
	pass

static func createTroopType(name):
	var troopType = new()
	troopType.name = name
	if name == "light infantry":
		troopType.attack = 2
		troopType.defense = 1
		troopType.counter = 1
	return troopType
