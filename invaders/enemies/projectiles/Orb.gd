class_name Orb
extends EnemyProjectile


func _ready():
	speed = 500.0
	pass


func _physics_process(delta:float):
	.move(delta)
