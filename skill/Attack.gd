extends "res://skill/Skill.gd"
	
var attack_bonus = 0
	
func _init():
	card_name = "attack"
	target_type = TargetType.ENEMY
	
func _use(target_column, battle):
	var total_attack = commander.selected_troop.troop_type.attack + commander.attack + attack_bonus
	var attacked_troop = target_column.commander.selected_troop
	var total_defense = attacked_troop.troop_type.defense + target_column.commander.defense
	var damage = 0
	var number = battle.engagement_width if commander.selected_troop.number > battle.engagement_width else commander.selected_troop.number
	for each_soldier in number:
		if total_attack * 5 > randi() % 100:
			if total_defense * 5 < randi() % 100:
				damage += 1
	attacked_troop.number -= damage
	attacked_troop.emit_signal("damaged", damage)
	return commander.card_name + " attacked " + target_column.commander.card_name + " for " + str(damage) + " damage"
	 