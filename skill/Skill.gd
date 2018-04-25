extends "res://Card.gd"

enum TargetType {SELF, ALLY, ENEMY}
# enum TargetColumnType {CENTER, VANGUARD, FLANK, SKIRMISH, REARGUARD}

var commander
var type
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





