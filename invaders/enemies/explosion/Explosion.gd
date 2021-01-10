extends Particles2D

class_name Explosion

func _ready():
	$Timer.wait_time = self.lifetime + 0.1
	$Timer.start()
	emitting = true


func _on_Timer_timeout():
	queue_free()
