extends "res://skill/Skill.gd"

func _init():
	card_name = "guard"
	target_type = TARGET_TYPE.ALLY
	
func _use(target, battle):
	var guarding = preload("res://status/Guarding.gd").new(commander, target)
	target.receive_status(guarding)
	return commander.card_name + " is guarding " + target.commander.card_name + ". "
	