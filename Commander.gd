extends "res://Card.gd"

var experience
var attack = 0
var defense = 0
var leadership = 0 # leadership * 100 = max troop
var command = 4 # how many cards are drawn

var ability_cards = []
var skill_cards = []
var reserve_troops = []

var drawed_cards = []
var selected_troop
var column

func _init(card_name, attack, defense, leadership, reserve_troops):
	self.card_name = card_name
	self.attack = attack
	self.defense = defense
	self.leadership = leadership
	self.reserve_troops = reserve_troops
	
func _craft_summary_string():
	return "A:" + str(attack) + " D:" + str(defense)

func _craft_image_path():
	return "res://image/hannibal.jpg"

