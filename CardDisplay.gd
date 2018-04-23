extends VBoxContainer

signal card_pressed

var card
var battle

func _ready():
	display_illustration()
	get_node("Text/Name").text = card.card_name
	display_summary()
	connect("gui_input", self, "_on_card_gui_input")
	if card != null:
		connect("card_pressed", battle, "_on_card_pressed")
	if card is preload("res://Troop.gd"):
		card.connect("damaged", self, "_on_card_damaged")
		card.connect("healed", self, "_on_card_healed")
	
func display_illustration():
	var imagePath = card._craft_image_path()
	var node = get_node("Illustration")
	node.texture = ImageTexture.new()
	node.texture.load(imagePath)

func _on_card_gui_input(event):
	if event.is_pressed():
		emit_signal("card_pressed", card)

func _on_card_damaged(damaged):
	display_summary()

func _on_card_healed(amount):
	display_summary()

func display_summary():
	get_node("Text/Summary").text = card._craft_summary_string()