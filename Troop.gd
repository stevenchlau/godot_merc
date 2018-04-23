extends "res://Card.gd"

var troop_type
var commander
var number

signal damaged
signal healed

func _init(troop_type, commander):
	self.troop_type = troop_type
	self.commander = commander
	self.card_name = troop_type.name
	self.number = 500
	
func _craft_summary_string():
	var summary = str("A:" , troop_type.attack, " D:", troop_type.defense, " C:", troop_type.counter, "\n")
	summary += str(number)
	return summary


