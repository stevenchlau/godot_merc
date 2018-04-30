extends Object

var battle
var opponent
var AI
var morale
var organization

var columns = []

func get_total_troop_count():
	var result = 0
	for column in columns:
		if !column.routed:
			result += column.commander.selected_troop.number
	return result
