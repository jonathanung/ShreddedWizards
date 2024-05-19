class_name Player extends CharacterBody2D

var MaxHealth: int = 100;
var CurrentHealth: float = 100

var MaxMana: int = 10
var CurrentMana: int = 10

var Muscle: int = 50

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

func setDefaultMaxAttributes():
	MaxHealth = 100
	MaxMana = 10
	Muscle = 50
	Gravity = 250
	JumpVelocity = -250
	MaxVelocityX = 250
	AccelerationX = 100

func BaseItemUsed(item: String):
	if (item == "Gloves"):
		CurrentHealth = min(CurrentHealth + 0.15 * MaxHealth, MaxHealth*1.15)
		await get_tree().create_timer(15.0).timeout
		setDefaultMaxAttributes()

	if (item == "Book"):
		CurrentHealth = min(CurrentHealth + 0.0666 * MaxHealth, MaxHealth*1.0666)
		CurrentMana = min(CurrentMana + 0.0666 * MaxMana, MaxMana*1.0666)
		Muscle *= 1.0666
		JumpVelocity *= 1.0666
		MaxVelocityX *= 1.0666
		await get_tree().create_timer(10.0).timeout
		setDefaultMaxAttributes()

	if (item == "Creatine"):
		CurrentMana = min(CurrentMana + 0.25 * MaxMana, MaxMana*1.25)
		await get_tree().create_timer(10.0).timeout
		setDefaultMaxAttributes()

	if (item == "LiftingStraps"):
		CurrentMana = min(CurrentMana + 0.1 * MaxMana, MaxMana*1.25)
		Muscle *= 1.1
		await get_tree().create_timer(10.0).timeout
		setDefaultMaxAttributes()

	if (item == "PreWorkout"):
		MaxVelocityX *= 1.25
		await get_tree().create_timer(15.0).timeout
		setDefaultMaxAttributes()

	if (item == "ProteinPowder"):
		Muscle *= 1.25
		await get_tree().create_timer(10.0).timeout
		setDefaultMaxAttributes()

func UltItemUsed(item: String):
	if (item == "Roids"):
		Muscle *= 1.5
		MaxVelocityX *= 1.5
		await get_tree().create_timer(10.0).timeout
		setDefaultMaxAttributes()

	if (item == "Baton"):
		#implement extra range later
		await get_tree().create_timer(25.0).timeout
		setDefaultMaxAttributes()
		pass

	if (item == "HealthPot"):
		CurrentHealth = CurrentHealth + (MaxHealth - CurrentHealth)*0.5
	if (item == "ManaPot"):
		CurrentMana = MaxMana
	if (item == "IceCream"):
		#implement Marvin Mode later
		MaxVelocityX *= 2.5
		await get_tree().create_timer(15.0).timeout
		setDefaultMaxAttributes()

# Called when the node enters the scene tree for the first time.
func _ready():
	item_Base = GlobalState.get_base_items()
	item_Ult = GlobalState.get_ultimate_item()

	BaseItemUsed(item_Base[1])
	pass

func _physics_process(delta):

	# Here I am just setting the index in the array to empty string after item has been used
	# We can find better way to implement in the future if we want - Sam
	if Input.is_action_just_pressed("item_slot_1"):
		BaseItemUsed(item_Base[0])
		item_Base[0] = ""
	if Input.is_action_just_pressed("item_slot_2"):
		BaseItemUsed(item_Base[1])
		item_Base[1] = ""
	if Input.is_action_just_pressed("item_super"):
		UltItemUsed(item_Ult)
		item_Ult = ""

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
 
