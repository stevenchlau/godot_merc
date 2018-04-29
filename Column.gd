extends GDScript

var army
var commander
var position #rearguard, center etc
var routed = false
var status = []

var column_display

signal selected_as_potential_target
signal deselected_as_potential_target
signal receive_status
signal status_expire

func _init(commander):
	self.commander = commander
	
func receive_status(a_status):
	status.append(a_status)
	a_status.used_on = self
	emit_signal("receive_status")
	a_status.connect("expire", self, "_on_status_expire")
	#display_status()

func _on_status_expire():
	emit_signal("status_expire")

		



