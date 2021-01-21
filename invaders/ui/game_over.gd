extends MarginContainer

onready var label = $CenterContainer/VBoxContainer/Label
onready var restartBtn = $CenterContainer/VBoxContainer/Restart
onready var quitBtn = $CenterContainer/VBoxContainer/Quit
onready var animation = $AnimationPlayer


func victory():
	label.text = "Victory"
	animation.play("Fade")


func defeat():
	label.text = "Defeat"
	animation.play("Fade")


func _on_Restart_pressed():
	get_tree().change_scene("res://main.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_AnimationPlayer_finished():
	restartBtn.grab_focus()
