extends "res://Battle.gd"

func initialize():
	randomize()
	player_army = preload("res://Army.gd").new()
	for x in range(0, 3):
		var player_commander = preload("res://Commander.gd").new(str("Hannibal", x), 3, 2, 2, [])
		var player_column = preload("res://Column.gd").new(player_commander)
		player_commander.reserve_troops.append(createTroop(player_commander))
		player_commander.selected_troop = player_commander.reserve_troops[0]
		player_commander.command += x
		player_commander.column = player_column
		player_column.position = player_column.POSITION["CENTER"]
		player_army.columns.append(player_column)
		for y in range(0, 10):
			var skill = preload("res://skill/Attack.gd").new()
			skill.commander = player_commander
			player_commander.skill_cards.append(skill)
		var heal = preload("res://skill/Heal.gd").new()
		heal.commander = player_commander
		player_commander.skill_cards.append(heal)
	
	
	enemy_army = preload("res://Army.gd").new()
	var enemy_commander = preload("res://Commander.gd").new("Roman", 1, 1, 1, [])
	enemy_commander.enemy = true
	var enemy_column = preload("res://Column.gd").new(enemy_commander)
	enemy_commander.reserve_troops.append(createTroop(enemy_commander))
	enemy_commander.selected_troop = enemy_commander.reserve_troops[0]
	enemy_commander.column = enemy_column
	enemy_army.columns.append(enemy_column)
	enemy_column.position = enemy_column.POSITION["CENTER"]
	
	column_width = 3
	engagement_width = 200

func createTroop(commander):
	var troop_type = preload("../TroopType.gd").createTroopType("light infantry")
	var troop = preload("res://Troop.gd").new(troop_type, commander)	
	troop.number = 500 + randi() % 100
	return troop
	
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
