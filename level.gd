extends Node2D

var playerResource = preload("res://player.tscn")
var player

@export var DefaultPlatformY: int = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $Player
	$YouLoseLabel.visible = false  # Initially hide the "You Lose" label
	$Timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	$Timer.stop()  # Ensure the timer is stopped initially
	$MapBoundary.connect("body_entered", Callable(self, "_on_map_boundary_body_entered"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.isDead() and $Timer.is_stopped():
		print("die")
		_show_you_lose_message()

func _show_you_lose_message():
	player.visible = false
	$YouLoseLabel.visible = true
	$Timer.start(3.0)  # Start the timer to wait for 3 seconds

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_area_2d_body_entered(body: Player):
	body.position = Vector2(position.x, position.y - 0.1)
	pass

# New function to handle the player entering the map boundary
func _on_map_boundary_body_entered(body):
	if body == player && player.visible == true:
		player.Die();
		#print("Player entered the map boundary")
		# Add your desired action here when the player enters the map boundary
