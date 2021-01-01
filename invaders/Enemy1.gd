extends RigidBody2D

signal enemy_killed

var point_value = 1000
var velocity = Vector2(0, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	linear_velocity = velocity


func _on_Enemy1_body_shape_entered(body_id, body, body_shape, local_shape):
	queue_free()
	emit_signal("enemy_killed", point_value)
