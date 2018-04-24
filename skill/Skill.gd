extends "res://Card.gd"

enum TargetType {SELF, ALLY, ENEMY}
enum TargetColumnType {CENTER, VANGUARD, FLANK, SKIRMISH, REARGUARD}

var commander
var type
# attack, assualt, scout, ambush etc
var target_type
# self, ally, enemy
var target_column_type
# center, vanguard, flank, skirmish, rearguard
var rarity
# how difficult to draw the card. 1 level = 10% to redraw

func _use(target, battle):
	pass





