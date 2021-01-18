extends MarginContainer

onready var resumeBtn = $VBoxContainer/ResumeButton
onready var restartBtn = $VBoxContainer/RestartButton
onready var quitBtn = $VBoxContainer/QuitButton

func _input(event):
	if event.is_action_pressed("pause", false):
		get_tree().set_input_as_handled()
		if get_tree().paused:
			unpause()
		else:
			pause()


func _on_ResumeButton_pressed():
	unpause()


func _on_RestartButton_pressed():
	unpause()
	get_tree().change_scene("res://main.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()


func pause():
	get_tree().paused = true
	visible = true
	resumeBtn.grab_focus()


func unpause():
	visible = false
	get_tree().paused = false
