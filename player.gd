class_name Player extends CharacterBody2D

var Health: int = 100;

var Muscle: int = 50;

var Mana: int = 10;

var Gravity: int = 400

var JumpForce: int = -1200

var Velocity: Vector2 = Vector2.ZERO

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

func BaseItemStats(item1: String, item2: String):
	if (item1 == "gloves" or item2 == "gloves"):
		print("Fuck you")

# Called when the node enters the scene tree for the first time.
func _ready():
	var item_Base: Array = GlobalState.get_base_items()
	var item_Ult: String = GlobalState.get_ultimate_item()

	BaseItemStats(item_Base[0], item_Base[1])
	print("fuck you")
	pass

func _physics_process(delta):	
	print("Y: ", position.y)
	
	if (not is_on_floor()):
		velocity.y = Gravity * 50 * delta
	else:
		velocity.y = 0

	if (Input.is_action_pressed("move_left")):

		self.velocity.x -= 1000 * delta

	elif (Input.is_action_pressed("move_right")):
		velocity.x += 1000 * delta

	elif (Input.is_action_pressed("jump")):
		while (is_on_floor()):
			velocity.y = JumpForce
		
	self.move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
 
