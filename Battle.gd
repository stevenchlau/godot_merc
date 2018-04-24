extends MarginContainer

var player_army
var enemy_army
var column_width # how many columns
var engagement_width # how many soldiers can join an action

var selected_skill # temp container for selected skill
var available_targets = [] #temp container for potential skill targets
var chozen_actions # dictionary in the format of {commander : [skill, target]}

func _ready():
	randomize()
	var battle = load("res://test/TestBattle.gd").new()
	battle.initialize()
	player_army = battle.player_army	
	enemy_army = battle.enemy_army
	column_width = battle.column_width
	engagement_width = battle.engagement_width
	reset_action()
	# $SceneBox.set_process_unhandled_input(false)
	draw_cards()
	display()
	
func display():
	var player_available_column_count = column_width if player_army.columns.size() > column_width else player_army.columns.size()
	for x in range(0, player_available_column_count):
		var column_display = preload("res://ColumnDisplay.tscn").instance()
		column_display.column = player_army.columns[x]
		player_army.columns[x].column_display = column_display
		column_display.battle = self
		column_display.display_card_from_bottom = true
		column_display.connect("column_selected", self, "_on_column_selected")
		get_node("SceneBox/BattleField/PlayerBackground/Player").add_child(column_display)

	var enemy_available_column_count = column_width if enemy_army.columns.size() > column_width else enemy_army.columns.size()
	for x in range(0, enemy_available_column_count):
		var column_display = preload("res://ColumnDisplay.tscn").instance()
		column_display.column = enemy_army.columns[x]
		enemy_army.columns[x].column_display = column_display
		column_display.battle = self
		column_display.display_card_from_bottom = false
		column_display.connect("column_selected", self, "_on_column_selected")
		get_node("SceneBox/BattleField/EnemyBackground/Enemy").add_child(column_display)

func reset_action():
	chozen_actions = {}
	var player_available_column_count = column_width if player_army.columns.size() > column_width else player_army.columns.size()
	for column_index in player_available_column_count:
		chozen_actions[player_army.columns[column_index].commander] = null	

func draw_cards():
	for column in player_army.columns:
		column.commander.drawed_cards = []
		for card_count in range(0, column.commander.command):
			var card_index = randi() % column.commander.skill_cards.size()
			column.commander.drawed_cards.append(column.commander.skill_cards[card_index])
			
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
		#selected_skill._use(column, self)
		chozen_actions[selected_skill.commander] = [selected_skill, column]
		unhightlight_potential_targets()
		clear_card_box()
		check_transit_to_resolve_scene()
		mark_column_as_action_chozen(selected_skill.commander.column.column_display)

func check_transit_to_resolve_scene():
	for action in chozen_actions.values():
		if action == null:
			return null
	get_tree().change_scene("res://BattleResolveScene.tscn")
		

func mark_column_as_action_chozen(column_display):
	column_display.get_node("ColorRect").color = Color(0, 0, 0)
	column_display.get_node("ColorRect").visible = true

func _gui_input(event):
	if event.is_pressed():
		clear_selected_skill()
		unhightlight_potential_targets()
		clear_card_box()

func highlight_available_targets(skill):
	if skill.target_type == skill.SELF:
		available_targets.append(skill.commander.column)
		skill.commander.column.emit_signal("selected_as_potential_target")
	elif skill.target_type == skill.ENEMY:
		for column in enemy_army.columns:
			available_targets.append(column)
			column.emit_signal("selected_as_potential_target")

func unhightlight_potential_targets():
	for old_target in available_targets:
		old_target.emit_signal("deselected_as_potential_target")
		available_targets = []

func clear_selected_skill():
	selected_skill = null