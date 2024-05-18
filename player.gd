class_name Player extends CharacterBody2D

var Health: int = 100;

var Muscle: int = 50;

var Mana: int = 10;

var Velocity: int = 0;

var resource = load("res://player_shape.tres")

func _init():
	pass	

func Die():
	self.Health = 0

func Damage(amount: int): 
	self.Health -= amount - self.Muscle * 3
	if (self.Health < 0):
		self.Die()

func UseMana(mana: int):
	self.Mana -= mana
	
	if (self.Mana < 0):
		self.Mana = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.velocity.x += 40
	pass

func _physics_process(delta):
	self.position.x += self.velocity.x * delta

func _input(event):	
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_RIGHT:
			self.position.x += 5
			
			#self.velo
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
