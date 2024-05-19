class_name Player extends CharacterBody2D

var Health: int = 100;

var Muscle: int = 50;

var Mana: int = 10;

var Gravity: int = 400

var JumpForce: int = -1200

var Velocity: Vector2 = Vector2.ZERO

var IsOnGround: bool = false

var GroundPosition = 580

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
	# self.velocity.x += 40
	pass

func _physics_process(delta):
	IsOnGround = position.y <= GroundPosition and position.y >= (GroundPosition - 2)
	
	print("Y: ", position.y)
	
	if (!IsOnGround):
		velocity.y = Gravity * 50 * delta
	else:
		velocity.y = 0

	if (Input.is_action_pressed("move_left")):

		self.velocity.x -= 1000 * delta

	elif (Input.is_action_pressed("move_right")):
		velocity.x += 1000 * delta

	elif (Input.is_action_pressed("jump")):
		while (IsOnGround):
			velocity.y = JumpForce
		
	self.move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
 
