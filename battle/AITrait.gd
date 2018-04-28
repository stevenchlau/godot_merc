extends GDScript

enum TARGET_MODE {STRONGEST, WEAKEST, RANDOM}

var conserve_morale_threshold
var conserve_organization_threshold
var recover_morale_threshold
var recover_organization_threshold
var guard_weakest_column_threshold

var target_mode

func assign_orders(AI):
	var orders = {}
	for column in AI.army.columns:
		var attack_cards = []
		for skill in column.commander.drawed_cards:
			if skill.types.has(skill.TYPE.ATTACK):
				



