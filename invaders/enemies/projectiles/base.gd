class_name EnemyProjectile
extends KinematicBody2D

export var speed:float = 0.0
export var damage:float = 0.0

onready var players = get_tree().get_nodes_in_group("Players")

var direction:Vector2 = Vector2.ZERO
var is_dead:bool = false

func _ready():
	add_to_group("EnemyProjectiles", true)
	pass


func move(delta:float) -> void:
	if is_dead:
		return
	
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		is_dead = true
		_die()
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


func _on_VisibilityNotifier2D_screen_exited():
	_die()


func _die():
	pass
