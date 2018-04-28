extends "res://status/Status.gd"

func _init(used_by, used_on):
	self.used_by = used_by
	self.used_on = used_on
	status_name = "guarding"
	has_countdown = true
	countdown = 3 

func _react(order):
	if order.skill.types.has(order.skill.TYPE.ATTACK):
		order.target = used_by.column
		return used_by.column.commander.card_name  + " guarded the attack. "
	return ""
	
		
	