extends MarginContainer

var column
var battle

signal column_selected

func _ready():
	display_card(column.commander)	
	display_card(column.commander.selected_troop)
	get_node("VBoxContainer/PositionLabel").text = column.position
	column.connect("selected_as_potential_target", self, "_on_column_selected_as_potential_target")
	column.connect("deselected_as_potential_target", self, "_on_column_deselected_as_potential_target")
	column.connect("receive_status", self, "_on_column_receive_status")
	column.connect("status_expire", self, "_on_column_status_expire")
	
func display_card(card):
	var card_display = preload("../CardDisplay.tscn").instance()
	card_display.card = card
	var cards_container = get_node("VBoxContainer/CardsContainer")	
	card_display.battle = battle	
	cards_container.add_child(card_display)
	
func _on_column_selected_as_potential_target():
	$ColorRect.color = Color(1, 1, 1)
	get_node("ColorRect").visible = true

func _on_column_deselected_as_potential_target():
	get_node("ColorRect").visible = false

func _gui_input(event):
	if event.is_pressed():
		emit_signal("column_selected", column)
	
func _on_column_receive_status():
	display_status()
	
func _on_column_status_expire():
	display_status()	
		
func display_status():
	var label = get_node("VBoxContainer/StatusLabel")
	label.text = ""
	for a_status in column.status:
		label.text += a_status.status_name + " "
