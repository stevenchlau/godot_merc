extends GDScript

var card_name
var commander
var level
var requirements = [null] 
# array of requirment arrays for different level. 
# null for level 0 EXCEPT for troops

var enemy = false

func is_enemy():
	return enemy

func _craft_summary_string():
	return ""

func _craft_image_path():
	return "res://image/" + card_name + ".jpg"
	
func is_acquirable(commander): # for both upgrading and leraning new skill
	var commander_card_level = get_commander_card_level(commander)
	if commander_card_level == get_max_level():
		return false
	var target_skill_level = commander_card_level + 1
	if self is load("res://Troop.gd"):
		target_skill_level = 0
	var level_requirements = requirements[target_skill_level]
	if level_requirements == null:
		return true
	var fulfilled = true
	for requirement in level_requirements:
		if !requirement._is_fulfilled(commander):
			fulfilled = false
	return fulfilled
	
func acquire(commander,level):
	var new_card = self.duplicate()
	new_card.commander = commander
	new_card.level = level
	if new_card is load("res://Troop.gd"):
		commander.reserve_troops.append(new_card)
	elif new_card is load("res://skill/Skill.gd"):
		commander.skill_cards.append(new_card)
	elif new_card is load("res://ability/Ability.gd"):
		commander.ability_cards.append(new_card)
		
func get_max_level():
	return requirements.size() - 1 # troop has a max level of 0

func get_commander_card_level(commander):
	var commander_card = get_card_in_commander()
	if commander_card == null:
		return null
	return commander_card.level
	
func get_card_in_commander(commander):
	for ability in commander.ability_cards:
		if ability.card_name == card_name:
			return ability
	for skill in commander.skill_cards:
		if skill.card_name == card_name:
			return skill
	for troop in commander.reserve_troops:
		if troop.card_name == card_name:
			return troop
	return null