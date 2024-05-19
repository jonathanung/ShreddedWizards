class_name Player extends CharacterBody2D

var MaxHealth: float = 100
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

var isLeftDir: bool
var isHost: bool

var bodiesLeft: Array = []
var bodiesRight: Array = []

@onready var sprite: Sprite2D = $Sprite2D

enum AttackType {
	BASIC,
	STRONG,
	RANGED
}

func _init():
	pass	

func Die():
	print("Died")
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

	elif (item == "Book"):
		CurrentHealth = min(CurrentHealth + 0.0666 * MaxHealth, MaxHealth*1.0666)
		CurrentMana = min(CurrentMana + 0.0666 * MaxMana, MaxMana*1.0666)
		Muscle *= 1.0666
		JumpVelocity *= 1.0666
		MaxVelocityX *= 1.0666
		await get_tree().create_timer(10.0).timeout
		setDefaultMaxAttributes()

	elif (item == "Creatine"):
		CurrentMana = min(CurrentMana + 0.25 * MaxMana, MaxMana*1.25)
		await get_tree().create_timer(10.0).timeout
		setDefaultMaxAttributes()

	elif (item == "LiftingStraps"):
		CurrentMana = min(CurrentMana + 0.1 * MaxMana, MaxMana*1.25)
		Muscle *= 1.1
		await get_tree().create_timer(10.0).timeout
		setDefaultMaxAttributes()

	elif (item == "PreWorkout"):
		MaxVelocityX *= 1.25
		await get_tree().create_timer(15.0).timeout
		setDefaultMaxAttributes()

	elif (item == "ProteinPowder"):
		Muscle *= 1.25
		await get_tree().create_timer(10.0).timeout
		setDefaultMaxAttributes()

func UltItemUsed(item: String):
	if (item == "Roids"):
		Muscle *= 1.5
		MaxVelocityX *= 1.5
		await get_tree().create_timer(10.0).timeout
		setDefaultMaxAttributes()

	elif (item == "Baton"):
		#implement extra range later
		await get_tree().create_timer(25.0).timeout
		setDefaultMaxAttributes()
		pass

	elif (item == "HealthPot"):
		CurrentHealth = CurrentHealth + (MaxHealth - CurrentHealth)*0.5

	elif (item == "ManaPot"):
		CurrentMana = MaxMana

	elif (item == "IceCream"):
		#implement Marvin Mode later
		MaxVelocityX *= 2.5
		await get_tree().create_timer(15.0).timeout
		setDefaultMaxAttributes()

# Called when the node enters the scene tree for the first time.
func _ready():
	item_Base = GlobalState.get_base_items()
	item_Ult = GlobalState.get_ultimate_item()
	
	isLeftDir = false;
	isHost = true;
	$LeftZone.connect("body_entered", Callable(self, "_left_zone_entered"))
	$LeftZone.connect("body_exited", Callable(self, "_left_zone_exited"))
	$RightZone.connect("body_entered", Callable(self, "_right_zone_entered"))
	$RightZone.connect("body_exited", Callable(self, "_right_zone_exited"))

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
	if Input.is_action_just_pressed("basic"):
		attack(AttackType.BASIC)
	#do timers here
	if Input.is_action_just_pressed("strong"):
		attack(AttackType.STRONG)
	#do timers here

	if not is_on_floor():
		velocity.y += Gravity*delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JumpVelocity
		
	var direction = Input.get_axis("move_left","move_right")
	if direction:
		velocity.x = move_toward(velocity.x,MaxVelocityX*direction,AccelerationX)
		#print(velocity.x)
		isLeftDir = direction < 0
		flip_sprite()
	else:
		velocity.x = move_toward(velocity.x,0,AccelerationX)
		#print(velocity.x)
		
	self.move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("die"):
		#print("Force Die")
		Die()
	
func isDead():
	if self.CurrentHealth <= 0:
		return true
	return false
	
func attack(Atk):
	if isLeftDir:
		for body in bodiesLeft:
			if body is Player:
				body.takeDamage(Atk, Muscle)
			elif body is Dummy:
				body.takeDamage(Atk, Muscle)
	else:
		for body in bodiesRight:
			if body is Player:
				body.takeDamage(Atk, Muscle)
			elif body is Dummy:
				#print("Hit!")
				body.takeDamage(Atk, Muscle)
			
func takeDamage(Atk, Muscle):
	if Atk == AttackType.BASIC:
		CurrentHealth -= .04*Muscle
	elif Atk == AttackType.STRONG:
		CurrentHealth -= .1*Muscle
	elif Atk == AttackType.RANGED:
		CurrentHealth -= .03*Muscle

func _left_zone_entered(body):
	if body != self && body not in bodiesLeft:
		bodiesLeft.append(body)
		#print(typeof(body))

func _left_zone_exited(body):
	if body != self && body in bodiesLeft:
		bodiesLeft.erase(body)
		#print(typeof(body))
		
func _right_zone_entered(body):
	if body != self && body not in bodiesRight:
		bodiesRight.append(body)
		#print(typeof(body))

func _right_zone_exited(body):
	if body != self && body in bodiesRight:
		bodiesRight.erase(body)
		#print(typeof(body))

func getHP():
	return self.CurrentHealth

func flip_sprite():
	$Sprite2D2.flip_h = !isLeftDir
