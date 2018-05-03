extends "res://ability/requirement/Requirement.gd"

var level 

func _is_fulfilled(commander):
	return commander.level >= level