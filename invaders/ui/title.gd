extends MarginContainer

signal start_game

onready var startLabel = $CenterContainer/VBoxContainer/Start
onready var timer = $Timer


func _ready():
	startLabel.modulate = Color.transparent

func _input(event):
	if event is InputEvent:
		if (event.is_action_pressed("pause") or 
			event.is_action_pressed("ui_accept")
		):
			emit_signal("start_game")
			get_tree().set_input_as_handled()


func _on_Timer_timeout():
	timer.wait_time = 0.5
	timer.start()
	if startLabel.modulate.a == 1.0:
		startLabel.modulate.a = 0.0
	else:
		startLabel.modulate.a = 1.0
