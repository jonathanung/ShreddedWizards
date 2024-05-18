extends Control

const MAX_BASE_ITEMS = 2
var selected_base_items = []
var selected_ultimate_item = null

func _ready():
	var hbox = $HBoxContainer
	hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.size_flags_vertical = Control.SIZE_EXPAND_FILL

	var base_vbox = hbox.get_node("BaseVBox")
	base_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	base_vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL

	var ultimate_vbox = hbox.get_node("UltimateVBox")
	ultimate_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	ultimate_vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var base_items = $HBoxContainer/BaseVBox/BaseItemsGridContainer.get_children()
	for item in base_items:
		item.pressed.connect(_on_base_item_selected)
	
	var ultimate_items = $HBoxContainer/UltimateVBox/UltimateItemGridContainer.get_children()
	for item in ultimate_items:
		item.pressed.connect(_on_ultimate_item_selected)

func _on_base_item_selected(item_name):
	if item_name in selected_base_items:
		selected_base_items.erase(item_name)
	elif selected_base_items.size() < MAX_BASE_ITEMS:
		selected_base_items.append(item_name)
	_update_base_item_buttons()

func _on_ultimate_item_selected(item_name):
	if selected_ultimate_item == item_name:
		selected_ultimate_item = null
	else:
		selected_ultimate_item = item_name
	_update_ultimate_item_buttons()

func _update_base_item_buttons():
	var base_items = $HBoxContainer/BaseVBox/BaseItemsGridContainer.get_children()
	for item in base_items:
		item.disabled = item.item_name in selected_base_items or selected_base_items.size() >= MAX_BASE_ITEMS and item.item_name not in selected_base_items

func _update_ultimate_item_buttons():
	var ultimate_items = $HBoxContainer/UltimateVBox/UltimateItemGridContainer.get_children()
	for item in ultimate_items:
		item.disabled = selected_ultimate_item and item.item_name != selected_ultimate_item
