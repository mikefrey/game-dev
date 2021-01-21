class_name Orb
extends EnemyProjectile


func _physics_process(delta:float):
	.move(delta)


func _die():
	queue_free()