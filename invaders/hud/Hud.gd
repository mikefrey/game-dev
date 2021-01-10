extends CanvasLayer

class_name HUD

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_score(score):
	$ScoreLabel.text = str(score)

func set_energy(energy):
	$Energy.value = energy
