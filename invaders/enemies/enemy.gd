class_name Enemy
extends KinematicBody2D

export (PackedScene) var ExplosionScene
export var hp := 18
export var point_value := 1000
export var speed = 200

var direction = Vector2.DOWN

signal enemy_killed
signal enemy_fired

onready var players = get_tree().get_nodes_in_group("Players")
var screen_rect

func _ready():
	screen_rect = get_viewport_rect()
	pass


func move(delta:float):
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		print("KEnemy Collision Detected")


func die():
	var explosion: Explosion = ExplosionScene.instance()
	get_parent().add_child(explosion)
	explosion.global_position = global_position
	
	# remove the enemy
	queue_free()
	# signal the enemy was killed and provide points
	emit_signal("enemy_killed", point_value)


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
	
