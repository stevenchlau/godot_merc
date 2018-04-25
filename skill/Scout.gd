extends "res://skill/Skill.gd"

func _init():
	card_name = "scout"
	target_type = TargetType.ENEMY
	var position = preload("res://Column.gd").POSITION
	target_column_types = [position.VANGUARD, position.CENTER, position.FLANK, position.SKIRMISH, position.REARGUARD]
	

func _use(target, battle):
	var scout_status = preload("res://status/Scouting.gd").new()
	target.receive_status(scout_status)
