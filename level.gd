extends Node2D

var playerResource = preload("res://player.tscn")

@export var DefaultPlatformY: int = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body: Player):
	body.position = Vector2(position.x, position.y - 0.1)
	pass
	
