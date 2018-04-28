extends GDScript

const POSITION = {CENTER = "center", VANGUARD = "vanguard", REARGUARD = "rearguard", SKIRMISH = "skirmish", FLANK = "flank"}

var army
var commander
var position #rearguard, center etc
var routed = false
var status = []

var column_display

signal selected_as_potential_target
signal deselected_as_potential_target
signal receive_status

func _init(commander):
	self.commander = commander
	
func receive_status(a_status):
	status.append(a_status)
	a_status.used_on = self
	emit_signal("receive_status")
	#display_status()


		



