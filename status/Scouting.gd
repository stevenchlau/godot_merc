extends "res://status/Status.gd"



func _init(used_by, used_on):
	self.used_by = used_by
	self.used_on = used_on
	status_name = "scouting"
	has_countdown = true
	countdown = 3
