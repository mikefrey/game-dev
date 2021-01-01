extends RigidBody2D

var velocity = Vector2(0, -750)

func _ready():
	linear_velocity = velocity


func _process(delta):
	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
