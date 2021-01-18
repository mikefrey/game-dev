class_name HUD
extends MarginContainer

onready var energyBar = $NinePatchRect/Energy
onready var shieldBar = $NinePatchRect/Shields
onready var scoreLabel = $NinePatchRect/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_score(score):
	scoreLabel.text = str(score)

func set_energy(energy):
	energyBar.value = energy

func set_shields(shields):
	shieldBar.value = shields
