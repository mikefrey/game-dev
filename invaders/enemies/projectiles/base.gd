class_name EnemyProjectile
extends KinematicBody2D

export var speed:float = 0.0
export var damage:float = 0.0

onready var players = get_tree().get_nodes_in_group("Players")

var direction = Vector2.ZERO


func _ready():
	add_to_group("EnemyProjectiles", true)
	pass


func move(delta:float) -> void:
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		queue_free()
		if collision.collider.has_method("hit"):
			collision.collider.hit(damage)


func closest_target() -> Node2D:
	return find_closest(players)


func find_closest(nodes:Array) -> Node2D:
	var closest:Node2D = null
	var length := INF

	for n in nodes:
		var dist = (n.position - position).length()
		if dist < length:
			closest = n
			length = dist
	
	return closest