class_name EnemyProjectile
extends KinematicBody2D

export var speed:float = 0.0

var direction = Vector2.ZERO


func _ready():
	add_to_group("EnemyProjectiles", true)
	pass


func move(delta:float) -> void:
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		print("EnemyProjectile collided")
