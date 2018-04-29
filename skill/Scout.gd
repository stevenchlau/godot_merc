extends "res://skill/Skill.gd"

func _init():
	card_name = "scout"
	target_type = TARGET_TYPE.ENEMY
	var position = preload("res://battle/Position.gd").POSITION_NAME
	target_column_types = [position.VANGUARD, position.CENTER, position.FLANK, position.SKIRMISH, position.REARGUARD]
	

func _use(target, battle):
	var scout_status = preload("res://status/Scouting.gd").new(commander, target)
	target.receive_status(scout_status)
	return commander.card_name + " is scouting " + target.commander.card_name + ". "
