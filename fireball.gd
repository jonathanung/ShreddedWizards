extends Node2D

var speed = 250

enum AttackType {
	BASIC,
	STRONG,
	RANGED
}

func _ready():
	$Area2D.connect("body_entered",Callable(self,"_fireball_hit"))
	$Area2D.connect("body_exited",Callable(self,"_fireball_exited"))

func _physics_process(delta):
	position += transform.x * speed * delta
	
func die():
	queue_free()

func _fireball_hit(body):
	if body is Player:
		body.takeDamage(AttackType.RANGED,50)
	if body is Dummy:
		body.takeDamage(AttackType.RANGED,50)
	die()
