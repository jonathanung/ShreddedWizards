extends Control

var NetworkPane

# Function called when the Start Button is pressed
func _on_StartButton_pressed():
	#NetworkPane.set_visible(true)
	get_tree().change_scene_to_file("res://item_select.tscn")
	

# Function called when the Settings Button is pressed
func _on_SettingsButton_pressed():
	get_tree().change_scene_to_file("res://item_select.tscn")

# Function called when the Exit Button is pressed
func _on_ExitButton_pressed():
	get_tree().quit()

# Function to set button opacity and text color
func set_button_opacity(button: Button):
	var style_normal = StyleBoxFlat.new()
	style_normal.bg_color = Color(1, 1, 1)  # Fully opaque white background
	button.add_theme_stylebox_override("normal", style_normal)

	var style_hover = StyleBoxFlat.new()
	style_hover.bg_color = Color(1, 1, 1)  # Fully opaque white background
	button.add_theme_stylebox_override("hover", style_hover)

	var style_pressed = StyleBoxFlat.new()
	style_pressed.bg_color = Color(1, 1, 1)  # Fully opaque white background
	button.add_theme_stylebox_override("pressed", style_pressed)

	# Set text color to black
	button.add_theme_color_override("font_color", Color(0, 0, 0))  # Black text color

func _ready():
	NetworkPane = $NetworkPane
	
	$VBoxContainer/StartButton.text = "Start Game"
	$VBoxContainer/SettingsButton.text = "Settings"
	$VBoxContainer/ExitButton.text = "Exit"

	$VBoxContainer/StartButton.set_size(Vector2(200, 50))
	$VBoxContainer/SettingsButton.set_size(Vector2(200, 50))
	$VBoxContainer/ExitButton.set_size(Vector2(200, 50))

	$VBoxContainer/StartButton.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	$VBoxContainer/StartButton.size_flags_vertical = Control.SIZE_EXPAND_FILL
	$VBoxContainer/SettingsButton.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	$VBoxContainer/SettingsButton.size_flags_vertical = Control.SIZE_EXPAND_FILL
	$VBoxContainer/ExitButton.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	$VBoxContainer/ExitButton.size_flags_vertical = Control.SIZE_EXPAND_FILL

	set_button_opacity($VBoxContainer/StartButton)
	set_button_opacity($VBoxContainer/SettingsButton)
	set_button_opacity($VBoxContainer/ExitButton)
	
	$VBoxContainer/StartButton.pressed.connect(_on_StartButton_pressed)
	$VBoxContainer/SettingsButton.pressed.connect(_on_SettingsButton_pressed)
	$VBoxContainer/ExitButton.pressed.connect(_on_ExitButton_pressed)
