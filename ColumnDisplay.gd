extends MarginContainer

var column
var battle
var display_card_from_bottom

signal column_selected


func get_frontline():
	return column.deployed_troops.front()
	
func _ready():
	display_card(column.commander)	
	display_card(column.commander.selected_troop)
	get_node("VBoxContainer/PositionLabel").text = column.position
	column.connect("selected_as_potential_target", self, "_on_column_selected_as_potential_target")
	column.connect("deselected_as_potential_target", self, "_on_column_deselected_as_potential_target")
	
func display_card(card):
	var card_display = preload("../CardDisplay.tscn").instance()
	card_display.card = card
	var cards_container = get_node("VBoxContainer/CardsContainer")	
	card_display.battle = battle	
	cards_container.add_child(card_display)
	if display_card_from_bottom:
		cards_container.alignment = cards_container.ALIGN_END
	else:
		cards_container.alignment = cards_container.ALIGN_BEGIN
	
func _on_column_selected_as_potential_target():
	$ColorRect.color = Color(1, 1, 1)
	get_node("ColorRect").visible = true

func _on_column_deselected_as_potential_target():
	get_node("ColorRect").visible = false

func _gui_input(event):
	if event.is_pressed():
		emit_signal("column_selected", column)
