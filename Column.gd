extends GDScript

const POSITION = {CENTER = "center", VANGUARD = "vanguard", REARGUARD = "rearguard", SKIRMISH = "skirmish", FLANK = "flank"}

var commander
var deployed_troops = []
var column_display
var position #rearguard, center etc

signal selected_as_potential_target
signal deselected_as_potential_target

func _init(commander):
	self.commander = commander
	

	



