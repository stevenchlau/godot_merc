extends GDScript

enum TARGET_MODE {STRONGEST, WEAKEST, RANDOM}

var conserve_morale_threshold
var conserve_organization_threshold
var recover_morale_threshold
var recover_organization_threshold
var guard_weakest_column_threshold

var target_mode
var AI

func assign_orders(AI):
	var orders = {}
	var priority_target = get_priority_target()
	for column in AI.army.columns:
		var attack_cards = []
		for skill in column.commander.drawed_cards:
			if skill.types.has(skill.TYPE.ATTACK):
				var available_targets = skill.find_available_targets()
				if available_targets.has(priority_target):
					var order = preload("res://skill/Order.gd").new(skill, priority_target, AI.army.battle)
					AI.chozen_actions[column.commander] = order
					break
		#fallback: random skill on random target
		if ! AI.chozen_actions.keys().has(column.commander):
			var random_skill = column.commander.drawed_cards[randi() % column.commander.drawed_cards.size()]
			var available_targets = random_skill.find_available_targets()
			var random_target = available_targets[randi() % available_targets.size()]
			var order = preload("res://skill/Order.gd").new(random_skill, random_target, AI.army.battle)
			AI.chozen_actions[column.commander] = order

func get_priority_target():
	if target_mode == STRONGEST:
		return AI.opponent_strongest_column
	if target_mode == WEAKEST:
		return AI.opponent_weakest_column
