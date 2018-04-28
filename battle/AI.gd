extends GDScript

var army

var self_strongest_column
var self_weakest_column
var opponent_strongest_column
var opponent_weakest_column

var AI_trait
var chozen_actions = {} #dictionary in the format of {commander: order}

func _init(AI_trait):
	self.AI_trait = AI_trait
	AI_trait.AI = self

func think():
	chozen_actions = {}
	find_self_strongest_column()
	find_self_weakest_column()
	find_opponent_strongest_column()
	find_opponen_weakest_column()
	assign_orders()
	return chozen_actions

func find_self_strongest_column():
	self_strongest_column = find_strongest_column(army.columns)

func find_self_weakest_column():
	self_weakest_column = find_weakest_column(army.columns)
	
func find_opponent_strongest_column():
	opponent_strongest_column = find_strongest_column(army.opponent.columns)
	
func find_opponen_weakest_column():
	opponent_weakest_column = find_weakest_column(army.opponent.columns)

func find_weakest_column(columns):
	var weakest_column = columns[0]
	for column in columns:
		if column.commander.selected_troop.number < weakest_column.commander.selected_troop.number:
			weakest_column = column
	return weakest_column
	
func find_strongest_column(columns):
	var strongest_column = columns[0]
	var strongest_column_total_attack = get_total_attack(strongest_column)
	for column in columns:
		if get_total_attack(column) > strongest_column_total_attack:
			strongest_column = column
			strongest_column_total_attack = get_total_attack(column)
	return strongest_column

func get_total_attack(column):
	return column.commander.attack + column.commander.selected_troop.troop_type.attack

func assign_orders():
	return AI_trait.assign_orders(self)


