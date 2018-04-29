extends "res://battle/Position.gd"

func _init():
	position_name = POSITION_NAME.SKIRMISH
	morale_recovery_per_turn = 0
	organization_recovery_per_turn = 0
	morale_penalty_on_rout = 5
	organziation_penalty_on_rout = 5