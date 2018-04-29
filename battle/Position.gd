extends GDScript

# skill only has position names in target_column_types instead of the whole object
const POSITION_NAME = {CENTER = "center", VANGUARD = "vanguard", REARGUARD = "rearguard", SKIRMISH = "skirmish", FLANK = "flank"}

var morale_recovery_per_turn
var organization_recovery_per_turn

var morale_penalty_on_rout
var organziation_penalty_on_rout

var position_name

func apply_turn_start_bonus(army):
	army.morale += morale_recovery_per_turn
	army.organization += organization_recovery_per_turn
	
func apply_on_rout_penalty(army):
	army.morale -= morale_penalty_on_rout
	army.organization -= organziation_penalty_on_rout


	
	