extends Area2D

var speed = 500

enum AttackType {
	BASIC,
	STRONG,
	RANGED
}

func _physics_process(delta):
	position += transform.x * speed * delta
	
func die():
	queue_free()

func _on_Area2D_body_entered(body):
	print(body.name)
	if body is Player:
		body.takeDamage(AttackType.RANGED, 100)
	elif body is Dummy:
		body.takeDamage(AttackType.RANGED, 100)
	die()
