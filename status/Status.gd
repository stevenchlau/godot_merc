extends GDScript

var status_name
var has_countdown
var countdown
var column

func countdown():
	countdown -= 1
	if countdown == 0:
		column.status.erase(self)
		column.display_status()
		 