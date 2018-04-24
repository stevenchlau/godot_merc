extends "res://skill/Skill.gd"

var heal_amount

func _init():
	card_name = "heal"
	target_type = SELF
	heal_amount = 100
	

func _use(target, battle):
	target.commander.selected_troop.number += heal_amount
	target.commander.selected_troop.emit_signal("healed", heal_amount)
	return target.commander.card_name + " healed for " + str(heal_amount) 