extends "res://Card.gd"

const TARGET_TYPE = {SELF = "self", ALLY = "ally", ENEMY = "enemy"}
const TYPE = {ATTACK = "attack", SCOUT = "scout", AMBUSH = "ambush"}

var types = []
# attack, assualt, scout, ambush etc
var target_type
# self, ally, enemy
var target_column_types = []
# center, vanguard, flank, skirmish, rearguard; all = put all; 
#if targetting enemy and the column type does not exist, than can attack the center

var rarity
# how difficult to draw the card. 1 level = 10% to redraw

func _use(target, battle):
	pass
	
func find_available_targets():
	var available_targets = []
	if target_type == TARGET_TYPE.SELF:
		available_targets.append(commander.column)
	elif target_type == TARGET_TYPE.ALLY:
		for column in commander.column.army.columns:
			available_targets.append(column)
	elif target_type == TARGET_TYPE.ENEMY:
		for column in commander.column.army.opponent.columns:
			if target_column_types.has(column.position.position_name) and ! column.routed:
				available_targets.append(column)
		if available_targets.size() == 0:
			for column in commander.column.army.opponent.columns:
				if column.position.position_name == preload("res://battle/Position.gd").POSITION_NAME.CENTER and ! column.routed:
					available_targets.append(column)
	return available_targets




