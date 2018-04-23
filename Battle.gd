extends MarginContainer

var player_army
var enemy_army
var column_width # how many columns
var engagement_width # how many soldiers can join an action

var selected_skill # temp container for selected skill
var available_targets = [] #temp container for potential skill targets

func _ready():
	randomize()
	var battle = load("res://test/TestBattle.gd").new()
	battle.initialize()
	player_army = battle.player_army	
	enemy_army = battle.enemy_army
	column_width = battle.column_width
	engagement_width = battle.engagement_width
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

func draw_cards():
	for column in player_army.columns:
		column.commander.drawed_cards = []
		for card_count in range(0, column.commander.command):
			var card_index = randi() % column.commander.skill_cards.size()
			column.commander.drawed_cards.append(column.commander.skill_cards[card_index])
			
func display_drawed_cards(commander):
	for existing_cards in get_node("SceneBox/CardBoxBackground/CardBox").get_children():
		existing_cards.queue_free()
	
	for card in commander.drawed_cards:
		var card_display = preload("res://CardDisplay.tscn").instance()
		card_display.card = card
		card_display.battle = self
		var center_container = CenterContainer.new()
		center_container.add_child(card_display)
		get_node("SceneBox/CardBoxBackground/CardBox").add_child(center_container)
	
func _on_card_pressed(card):
	if ! card.is_enemy():
		if card is preload("res://Commander.gd"):
			display_drawed_cards(card)
		if card is preload("res://skill/Skill.gd"):
			selected_skill = card
			highlight_available_targets(card)

func _on_column_selected(column):
	if selected_skill != null and available_targets.find(column) != -1:
		selected_skill._use(column, self)

func _gui_input(event):
	if event.is_pressed():
		unhightlight_potential_targets()

func highlight_available_targets(skill):
	if skill.target_type == skill.SELF:
		available_targets.append(skill.commander.column)
		skill.commander.column.emit_signal("selected_as_potential_target")
	elif skill.target_type == skill.ENEMY:
		for column in enemy_army.columns:
			available_targets.append(column)
			column.emit_signal("selected_as_potential_target")

func unhightlight_potential_targets():
	selected_skill = null
	for old_target in available_targets:
		old_target.emit_signal("deselected_as_potential_target")
		available_targets = []