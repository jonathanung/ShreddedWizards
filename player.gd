class_name Player extends CharacterBody2D

var Health: int = 100;

var Muscle: int = 50;

var Mana: int = 10;

var Gravity: int = 400

var JumpVelocity: int = -400

var MaxVelocityX: int = 1000

var AccelerationX: int = 500

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
	
	print("Y: ", position.y)
	
	if not is_on_floor():
		velocity.y += Gravity*delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JumpVelocity
		
	var direction = Input.get_axis("move_left","move_right")
	if direction:
		velocity.x = move_toward(velocity.x,MaxVelocityX*direction,AccelerationX)
	else:
		velocity.x = move_toward(velocity.x,0,AccelerationX)
		
	self.move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
 
