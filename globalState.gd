extends Node

# variables used from item_select
var selected_base_items = []
var selected_ultimate_item = null
const MAX_BASE_ITEMS = 2

#item_select functions global states
func set_base_items(item_name_1, item_name_2):
	selected_base_items = []
	selected_base_items.append(item_name_1)
	selected_base_items.append(item_name_2)
	print(selected_base_items)

func set_ultimate_item(item_name):
	selected_ultimate_item = item_name
	print(selected_ultimate_item)

#add getters for items
func get_base_items():
	return selected_base_items

func get_ultimate_item():
	return selected_ultimate_item