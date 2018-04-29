extends "res://battle/Position.gd"

func _init():
	position_name = POSITION_NAME.VANGUARD
	morale_recovery_per_turn = 2
	organization_recovery_per_turn = 0
	morale_penalty_on_rout = 15
	organziation_penalty_on_rout = 5