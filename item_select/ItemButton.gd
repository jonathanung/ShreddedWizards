extends TextureButton

signal item_selected(item_name)

var item_name
var icon_texture

func _ready():
	item_name = self.get_name()
	var icon_path = "res://sprites/powerups/%s.png" % item_name.to_lower()
	icon_texture = load(icon_path)
	
	var icon_rect = $Icon  # Reference to the TextureRect
	icon_rect.texture = icon_texture
	icon_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	self.custom_minimum_size = Vector2(64, 64)  # Ensure the button has a minimum size

	self.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	emit_signal("item_selected", item_name)
