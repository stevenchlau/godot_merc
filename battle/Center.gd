extends "res://battle/Position.gd"

func _init():
	position_name = POSITION_NAME.CENTER
	morale_recovery_per_turn = 1
	organization_recovery_per_turn = 1
	morale_penalty_on_rout = 10
	organziation_penalty_on_rout = 10