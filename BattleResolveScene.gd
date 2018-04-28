extends MarginContainer

var battle

func _ready():
	var timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	for order in battle.chozen_actions.values():
		var skill_use_summary = order.resolve() # action_array[0]._use(action_array[1], battle)
		if skill_use_summary != null:
			var label = Label.new()		
			label.text = skill_use_summary
			get_node("VBoxContainer/MessageContainer").add_child(label)
	timer.wait_time = 3
	timer.one_shot = true
	add_child(timer)
	timer.start()

func _on_timer_timeout():
	self.queue_free()
	battle.get_node("SceneBox").visible = true
	battle.new_turn()

