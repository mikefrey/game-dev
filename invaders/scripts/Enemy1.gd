extends RigidBody2D

signal enemy_killed

var hp = 30
var point_value = 1000
var velocity = Vector2(0, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	linear_velocity = velocity


func _on_Enemy1_body_shape_entered(body_id, body, body_shape, local_shape):
	var damage = body.get_damage()
	
	$HitParticles.global_transform = body.global_transform
	$HitParticles.emitting = true
	
	hp -= damage
	
	if hp <= 0:
		die()
		
	# remove the bullet
	body.queue_free()
	

func die():
	# remove the enemy
	queue_free()
	# signal the enemy was killed and provide points
	emit_signal("enemy_killed", point_value)
