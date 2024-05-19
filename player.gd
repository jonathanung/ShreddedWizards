class_name Player extends CharacterBody2D

var Health: float = 100
var CurrentHealth: float = 100
var Mana: int = 10
var CurrentMana: float = 10

var Muscle: float = 50
var Gravity: float = 400
var JumpForce: float = -1200
var Velocity: Vector2 = Vector2.ZERO

var item_Base: Array
var item_Ult: String

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

func BaseItemUsed(item: String):
	if (item == "Gloves"):
		CurrentHealth = min(CurrentHealth + 0.25 * Health, Health)
	if (item == "Book"):
		CurrentHealth = min(CurrentHealth + 0.0666 * Health, Health)
		CurrentMana = min(CurrentMana + 0.0666 * Mana, Mana)
		Muscle *= 1.0666
		JumpForce *= 1.0666
		Velocity *= 1.0666
	if (item == "Creatine"):
		CurrentMana = min(CurrentMana + 0.25 * Mana, Mana)
	if (item == "LiftingStraps"):
		CurrentMana = min(CurrentMana + 0.1 * Mana, Mana)
		Muscle *= 1.1
	if (item == "PreWorkout"):
		Velocity *= 1.25
	if (item == "ProteinPowder"):
		Muscle *= 1.25

func UltItemUsed(item: String):
	if (item == "Roids"):
		Muscle *= 1.5
		Velocity *= 1.5
	if (item == "Baton"):
		#implement extra range later
		pass
	if (item == "HealthPot"):
		#implement current health later
		CurrentHealth = min(CurrentHealth + 0.5 * Health, Health)
	if (item == "ManaPot"):
		CurrentMana = Mana
	if (item == "IceCream"):
		#implement Marvin Mode later
		Velocity *= 2.5

# Called when the node enters the scene tree for the first time.
func _ready():
	item_Base = GlobalState.get_base_items()
	item_Ult = GlobalState.get_ultimate_item()

	BaseItemUsed(item_Base[1])
	pass

func _physics_process(delta):		
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
 
