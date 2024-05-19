extends Control

const MAX_BASE_ITEMS = 2
var selected_base_items = []
var selected_ultimate_item = null
var baseLabel;
var ultimateLabel;
var errLabel;

func _ready():
	var parentv = $VBoxContainer
	parentv.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	parentv.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	var hbox = $VBoxContainer/HBoxContainer
	hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.size_flags_vertical = Control.SIZE_EXPAND_FILL

	var base_vbox = hbox.get_node("BaseVBox")
	base_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	base_vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL

	var ultimate_vbox = hbox.get_node("UltimateVBox")
	ultimate_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	ultimate_vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL

	# Connect signals for base items
	var base_items = $VBoxContainer/HBoxContainer/BaseVBox/BaseItemsGridContainer.get_children()
	for item in base_items:
		if item is TextureButton:
			item.connect("item_selected", Callable(self, "_on_base_item_selected"))

	# Connect signals for ultimate items
	var ultimate_items = $VBoxContainer/HBoxContainer/UltimateVBox/UltimateItemGridContainer.get_children()
	for item in ultimate_items:
		if item is TextureButton:
			item.connect("item_selected", Callable(self, "_on_ultimate_item_selected"))
	
	baseLabel = $VBoxContainer/HBoxContainer/TextVBox/BaseLabel
	ultimateLabel = $VBoxContainer/HBoxContainer/TextVBox/UltimateLabel
	errLabel = $VBoxContainer/HBoxContainer/TextVBox/ErrLabel
	
	baseLabel.text = "PLAYER 2 Base Items: "
	ultimateLabel.text = "PLAYER 2 Ultimate Item: "
	errLabel.text = ""
	
	var goButton = $VBoxContainer/Button
	goButton.pressed.connect(_on_go_press)
	
func _on_base_item_selected(item_name):
	if item_name in selected_base_items:
		selected_base_items.erase(item_name)
	elif selected_base_items.size() < MAX_BASE_ITEMS:
		selected_base_items.append(item_name)
	else:
		selected_base_items.append(item_name)
		selected_base_items.remove_at(0)
	_update_base_item_buttons()

func _on_ultimate_item_selected(item_name):
	if selected_ultimate_item == item_name:
		selected_ultimate_item = null
	else:
		selected_ultimate_item = item_name
	_update_ultimate_item_buttons()

func _update_base_item_buttons():
	#var base_items = $VBoxContainer/HBoxContainer/BaseVBox/BaseItemsGridContainer.get_children()
	#for item in base_items:
		#if item is TextureButton:
			#item.disabled = item.item_name in selected_base_items or (selected_base_items.size() >= MAX_BASE_ITEMS and item.item_name not in selected_base_items)
	baseLabel.text = "PLAYER 2 Base Items: "
	if len(selected_base_items) > 0:
		for i in range(len(selected_base_items)):
			baseLabel.text += selected_base_items[i]
			if i < len(selected_base_items) - 1:
				baseLabel.text += ", "
	#print(selected_base_items)

func _update_ultimate_item_buttons():
	#var ultimate_items = $VBoxContainer/HBoxContainer/UltimateVBox/UltimateItemGridContainer.get_children()
	#for item in ultimate_items:
		#if item is TextureButton:
			#item.disabled = selected_ultimate_item and item.item_name != selected_ultimate_item
	
	ultimateLabel.text = "PLAYER 2 Ultimate Item: "
	if selected_ultimate_item:
		ultimateLabel.text += selected_ultimate_item
	#print(selected_ultimate_item)
	
func _on_go_press():
	if(len(selected_base_items) == 2 and selected_ultimate_item):
		GlobalState.set_base_items_2(selected_base_items[0], selected_base_items[1])
		GlobalState.set_ultimate_item_2(selected_ultimate_item)
		#get_tree().change_scene_to_file("res://arenas/testing.tscn")
		get_tree().change_scene_to_file("res://arenas/testing.tscn")
	else:
		errLabel.text = ""
		if(len(selected_base_items) != 2):
			errLabel.text += "You must select 2 base items!\n"
		if not selected_ultimate_item:
			errLabel.text += "You must have an ultimate item!"
	
