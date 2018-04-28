extends GDScript

var skill
var target
var battle
var summary = ""

func _init(skill, target, battle):
	self.skill = skill
	self.target = target
	self.battle = battle
	
func resolve():
	var summary = ""
	for a_status in target.status:
		summary += a_status._react(self)
	summary += skill._use(target, battle)
	return summary