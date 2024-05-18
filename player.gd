class_name Player extends CharacterBody2D

var Health: int = 100;

var Muscle: int = 50;

var Mana: int = 10;

var Velocity: int = 0;

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
	move_and_collide(Vector2(0, 1))
	
	if (Input.is_action_pressed("move_left")):
		self.position.x -= self.velocity.x * delta
	elif (Input.is_action_pressed("move_right")):
		self.position.x += self.velocity.x * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
