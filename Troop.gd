extends "res://Card.gd"

var troop_type
var commander
var number

signal damaged
signal healed
signal routed

func _init(troop_type, commander):
	self.troop_type = troop_type
	self.commander = commander
	self.card_name = troop_type.name
	self.number = 500
	connect("damaged", self, "_on_troop_damaged")
	
func _craft_summary_string():
	var summary = str("A:" , troop_type.attack, " D:", troop_type.defense, " C:", troop_type.counter, "\n")
	summary += str(number)
	return summary

func _on_troop_damaged(damaged):
	if number <= 0:
		commander.column.routed = true
		commander.column.column_display.get_node("ColorRect").color = Color(1, 0, 0)
		commander.column.column_display.get_node("ColorRect").visible = true
		emit_signal("routed")
		number = 0	

