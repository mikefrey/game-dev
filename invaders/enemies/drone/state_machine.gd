extends StateMachine


func _ready():
	add_state("moving")
	add_state("firing")
	add_state("dying")

	call_deferred("set_state", states.moving)


func _state_logic(delta):
	match state:
		states.firing:
			return parent.fire(delta)
		states.dying:
			return parent.die()

	return parent.move(delta)


func _get_transition(delta):
	if parent.should_die():
		return states.dying
	
	match state:
		states.firing:
			return states.moving
		states.moving:
			if parent.should_fire():
				return states.firing

	return states.moving


func _enter_state(new_state, old_state):
	pass


func _exit_state(old_state, new_state):
	pass
	
