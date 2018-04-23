extends GDScript

var card_name
var enemy = false

func _craft_summary_string():
	return ""

func _craft_image_path():
	return "res://image/" + card_name + ".jpg"

func is_enemy():
	return enemy