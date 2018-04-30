extends MarginContainer

var player_army
var enemy_army
var all_columns = [] # a convenience variable for looping through all the columns
var column_width # how many columns
var engagement_width # how many soldiers can join an action

var selected_skill # temp container for selected skill
var available_targets = [] #temp container for potential skill targets
var chozen_actions # dictionary in the format of {commander : order}

func _ready():
	randomize()
	# test codes
	var battle = load("res://test/TestBattle.gd").new()
	battle.initialize()
	player_army = battle.player_army
	player_army.battle = self	
	enemy_army = battle.enemy_army	
	enemy_army.battle = self
	player_army.opponent = enemy_army
	enemy_army.opponent = player_army
	column_width = battle.column_width
	engagement_width = battle.engagement_width
	# end of test codes
	for column in player_army.columns:
		all_columns.append(column)
	for column in enemy_army.columns:
		all_columns.append(column)
	player_army.morale = 100
	player_army.organization = 100
	enemy_army.morale = 100
	enemy_army.organization = 100	
	draw_cards()
	display()
	reset_action()
	display_army_info()
	
func new_turn():
	reset_action()
	draw_cards()
	for column in all_columns:
		for a_status in column.status:
			if a_status.has_countdown:
				a_status.countdown()
	apply_position_turn_start_recovery()
	display_army_info()

func draw_cards():
	for column in all_columns:
		column.commander.drawed_cards = []
		for card_count in range(0, column.commander.command):
			var card_index = randi() % column.commander.skill_cards.size()
			column.commander.drawed_cards.append(column.commander.skill_cards[card_index])

func apply_position_turn_start_recovery():
	for column in all_columns:
		if !column.routed:
			column.position.apply_turn_start_recovery(column.army)
	
func display():
	var player_available_column_count = column_width if player_army.columns.size() > column_width else player_army.columns.size()
	for x in range(0, player_available_column_count):
		var column_display = preload("res://ColumnDisplay.tscn").instance()
		column_display.column = player_army.columns[x]
		player_army.columns[x].column_display = column_display
		column_display.battle = self
		column_display.connect("column_selected", self, "_on_column_selected")
		get_node("SceneBox/BattleField/PlayerBackground/VBoxContainer/Player").add_child(column_display)

	var enemy_available_column_count = column_width if enemy_army.columns.size() > column_width else enemy_army.columns.size()
	for x in range(0, enemy_available_column_count):
		var column_display = preload("res://ColumnDisplay.tscn").instance()
		column_display.column = enemy_army.columns[x]
		enemy_army.columns[x].column_display = column_display
		column_display.battle = self
		column_display.connect("column_selected", self, "_on_column_selected")
		get_node("SceneBox/BattleField/EnemyBackground/VBoxContainer/Enemy").add_child(column_display)

func reset_action():
	chozen_actions = {}
	var player_available_column_count = column_width if player_army.columns.size() > column_width else player_army.columns.size()
	for column_index in player_available_column_count:
		chozen_actions[player_army.columns[column_index].commander] = null
		player_army.columns[column_index].column_display.get_node("VBoxContainer/PositionLabel/ActionSelectedIndicator").visible = false	

func display_army_info():
	var info = "troops:" + str(player_army.get_total_troop_count()) + " morale:" + str(player_army.morale) + " organization:" + str(player_army.organization)
	get_node("SceneBox/BattleField/PlayerBackground/VBoxContainer/InfoContainer/InfoLabel").text = info
	info = "troops:" + str(enemy_army.get_total_troop_count()) + " morale:" + str(enemy_army.morale) + " organization:" + str(enemy_army.organization)
	get_node("SceneBox/BattleField/EnemyBackground/VBoxContainer/InfoContainer/InfoLabel").text = info

			
func display_drawed_cards(commander):
	clear_card_box()	
	for card in commander.drawed_cards:
		var card_display = preload("res://CardDisplay.tscn").instance()
		card_display.card = card
		card_display.battle = self
		var center_container = CenterContainer.new()
		center_container.add_child(card_display)
		get_node("SceneBox/CardBoxBackground/CardBox").add_child(center_container)

func clear_card_box():
	for existing_cards in get_node("SceneBox/CardBoxBackground/CardBox").get_children():
		existing_cards.queue_free()

func _on_card_pressed(card):
	if ! card.is_enemy():
		if card is preload("res://Commander.gd") and chozen_actions[card] == null:
			display_drawed_cards(card)
		if card is preload("res://skill/Skill.gd"):
			selected_skill = card
			highlight_available_targets(card)

func _on_column_selected(column):
	if selected_skill != null and available_targets.find(column) != -1:
		chozen_actions[selected_skill.commander] = preload("res://skill/Order.gd").new(selected_skill, column, self) # [selected_skill, column]
		unhightlight_potential_targets()
		clear_card_box()
		check_transit_to_resolve_scene()
		mark_column_as_action_chozen(selected_skill.commander.column.column_display)

func check_transit_to_resolve_scene():
	for order in chozen_actions.values():
		if order == null:
			return null
	var resolve_scene = preload("res://BattleResolveScene.tscn").instance()
	resolve_scene.battle = self
	$SceneBox.visible = false
	add_child(resolve_scene)

func mark_column_as_action_chozen(column_display):
	#column_display.get_node("ColorRect").color = Color(0, 0, 0)
	column_display.get_node("VBoxContainer/PositionLabel/ActionSelectedIndicator").visible = true

func _gui_input(event):
	if event.is_pressed():
		clear_selected_skill()
		unhightlight_potential_targets()
		clear_card_box()

func highlight_available_targets(skill):
	available_targets = skill.find_available_targets()
	for column in available_targets:
		column.emit_signal("selected_as_potential_target")

func unhightlight_potential_targets():
	for old_target in available_targets:
		old_target.emit_signal("deselected_as_potential_target")
	available_targets = []

func clear_selected_skill():
	selected_skill = null