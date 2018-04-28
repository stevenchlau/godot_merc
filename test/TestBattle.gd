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
		player_column.army = player_army
		for y in range(0, 2):
			var skill = preload("res://skill/Attack.gd").new()
			skill.commander = player_commander
			player_commander.skill_cards.append(skill)
		var heal = preload("res://skill/Heal.gd").new()
		heal.commander = player_commander
		player_commander.skill_cards.append(heal)
		var scout = preload("res://skill/Scout.gd").new()
		scout.commander = player_commander
		player_commander.skill_cards.append(scout)
		var guard = preload("res://skill/Guard.gd").new()
		guard.commander = player_commander
		player_commander.skill_cards.append(guard)		
	
	
	enemy_army = preload("res://Army.gd").new()
	for x in range(0, 3):
		var enemy_commander = preload("res://Commander.gd").new("Roman" + str(x), 1, 1, 1, [])
		enemy_commander.enemy = true
		var enemy_column = preload("res://Column.gd").new(enemy_commander)
		enemy_commander.reserve_troops.append(createTroop(enemy_commander))
		enemy_commander.selected_troop = enemy_commander.reserve_troops[0]
		enemy_commander.column = enemy_column
		enemy_army.columns.append(enemy_column)
		enemy_column.army = enemy_army
		enemy_column.position = enemy_column.POSITION["CENTER"]
		for y in range(0, 2):
			var skill = preload("res://skill/Attack.gd").new()
			skill.commander = enemy_commander
			enemy_commander.skill_cards.append(skill)		
		if x == 2:
			enemy_column.position = enemy_column.POSITION.VANGUARD
			enemy_commander.selected_troop.number = 50
	var AI = create_AI()
	enemy_army.AI = AI
	AI.army = enemy_army
	
	column_width = 3
	engagement_width = 200
	player_army.opponent = enemy_army
	enemy_army.opponent = player_army

func createTroop(commander):
	var troop_type = preload("../TroopType.gd").createTroopType("light infantry")
	var troop = preload("res://Troop.gd").new(troop_type, commander)	
	troop.number = 500 + randi() % 100
	return troop
	
func create_AI():
	var AI_trait = preload("res://battle/AITrait.gd").new()
	AI_trait.target_mode = AI_trait.TARGET_MODE.STRONGEST
	var AI = preload("res://battle/AI.gd").new(AI_trait)
	return AI

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
