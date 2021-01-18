extends Node2D

onready var title = $Title
onready var game = $Game
onready var pauseMenu = $PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	title.grab_focus()
	# Don't let the pause menu process input until new_game is called.
	pauseMenu.set_process_input(false)



func new_game():
	title.visible = false
	title.set_process_input(false)
	
	pauseMenu.set_process_input(true)
	game.new_game()	

