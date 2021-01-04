extends RigidBody2D

var velocity = Vector2(0, -750)
var damage = 10

func _ready():
	#linear_velocity = velocity
	apply_impulse(Vector2.ZERO, velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	
func get_damage():
	return damage
