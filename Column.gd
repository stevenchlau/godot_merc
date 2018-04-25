extends GDScript

const POSITION = {CENTER = "center", VANGUARD = "vanguard", REARGUARD = "rearguard", SKIRMISH = "skirmish", FLANK = "flank"}

var commander
var deployed_troops = []
var column_display
var position #rearguard, center etc
var routed = false
var status = []

signal selected_as_potential_target
signal deselected_as_potential_target

func _init(commander):
	self.commander = commander
	
func receive_status(a_status):
	status.append(a_status)
	a_status.column = self
	display_status()

func display_status():
	var label = column_display.get_node("VBoxContainer/StatusLabel")
	label.text = ""
	for a_status in status:
		label.text += a_status.status_name + " "
		



