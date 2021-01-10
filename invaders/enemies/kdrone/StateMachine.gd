extends StateMachine


func _ready():
	add_state("moving")
	add_state("aiming")
	add_state("firing")
	add_state("dying")

	call_deferred("set_state", states.moving)


func _state_logic(delta):
	match state:
		states.aiming:
			return parent.aim(delta)
		states.firing:
			return parent.fire(delta)

	return parent.move(delta)



func _get_transition(delta):
	match state:
		states.aiming:
			if parent.should_fire():
				return states.firing
			if parent.should_aim():
				return states.aiming
		states.firing:
			if parent.should_aim():
				return states.aiming
			return states.moving
		states.moving:
			if parent.should_fire():
				return states.firing
			if parent.should_aim():
				return states.aiming

	return states.moving


func _enter_state(new_state, old_state):
	pass


func _exit_state(old_state, new_state):
	pass
	
