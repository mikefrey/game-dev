extends Area2D

class_name Enemy

export (PackedScene) var ExplosionScene

signal enemy_killed
signal enemy_fired

var hp := 18
var point_value := 1000
var velocity = Vector2(0, 0)


func _ready():
	pass


func _process(delta:float):
	pass


func move(delta:float):
	position += velocity * delta


func die():
	var explosion: Explosion = ExplosionScene.instance()
	get_parent().add_child(explosion)
	explosion.global_position = global_position
	
	# remove the enemy
	queue_free()
	# signal the enemy was killed and provide points
	emit_signal("enemy_killed", point_value)


func _on_area_shape_entered(area_id, area:Area2D, area_shape, self_shape):
	if area.is_in_group("PlayerProjectile"):
		var damage = area.get_damage()
		
		$HitParticles.global_position = area.global_position
		$HitParticles.emitting = true
		
		hp -= damage
		
		if hp <= 0:
			die()
			
		area.queue_free()