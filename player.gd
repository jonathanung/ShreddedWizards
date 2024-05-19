class_name Player extends CharacterBody2D

var MaxHealth: int = 100;
var CurrentHealth: float = 100

var Muscle: int = 50;

var MaxMana: int = 10;
var CurrentMana: float = 10

var Gravity: int = 250

var JumpVelocity: int = -250

var MaxVelocityX: int = 250

var AccelerationX: int = 100

var item_Base: Array
var item_Ult: String

func _init():
	pass	

func Die():
	CurrentHealth = 0

func Damage(amount: int): 
	CurrentHealth -= amount - self.Muscle * 0.5
	if (CurrentHealth <= 0):
		self.Die()

func UseMana(mana: int):
	CurrentMana -= mana
	
	if (CurrentMana < 0):
		CurrentMana = 0

func BaseItemUsed(item: String):
	if (item == "Gloves"):
		CurrentHealth = min(CurrentHealth + 0.25 * MaxHealth, MaxHealth)
	if (item == "Book"):
		CurrentHealth = min(CurrentHealth + 0.0666 * MaxHealth, MaxHealth)
		CurrentMana = min(CurrentMana + 0.0666 * MaxMana, MaxMana)
		Muscle *= 1.0666
		JumpVelocity *= 1.0666
		MaxVelocityX *= 1.0666
	if (item == "Creatine"):
		CurrentMana = min(CurrentMana + 0.25 * MaxMana, MaxMana)
	if (item == "LiftingStraps"):
		CurrentMana = min(CurrentMana + 0.1 * MaxMana, MaxMana)
		Muscle *= 1.1
	if (item == "PreWorkout"):
		MaxVelocityX *= 1.25
	if (item == "ProteinPowder"):
		Muscle *= 1.25

func UltItemUsed(item: String):
	if (item == "Roids"):
		Muscle *= 1.5
		MaxVelocityX *= 1.5
	if (item == "Baton"):
		#implement extra range later
		pass
	if (item == "HealthPot"):
		#implement current health later
		CurrentHealth = min(CurrentHealth + 0.5 * MaxHealth, MaxHealth)
	if (item == "ManaPot"):
		CurrentMana = MaxMana
	if (item == "IceCream"):
		#implement Marvin Mode later
		MaxVelocityX *= 2.5

# Called when the node enters the scene tree for the first time.
func _ready():
	item_Base = GlobalState.get_base_items()
	item_Ult = GlobalState.get_ultimate_item()

	BaseItemUsed(item_Base[1])
	pass

func _physics_process(delta):

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
 
