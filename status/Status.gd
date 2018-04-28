extends GDScript

var status_name
var used_on # column
var used_by # commander
var has_countdown
var countdown

signal expire

func countdown():
	countdown -= 1
	if countdown == 0:
		used_on.status.erase(self)
		emit_signal("expire")
		

func _react(order):
	return ""	 