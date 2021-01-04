extends Node2D

export (PackedScene) var Drone

signal spawn_mob

var wave_position = 0
var subwaves = [
	[1, 2],
	[0, 3],
	[1, 3],
	[0, 2],
	[1, 2],
	[0, 1, 2, 3]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if wave_position >= subwaves.size():
		return
	
	var subwave = subwaves[wave_position]
	for point in subwave:
		var spawn = get_child(point)
		var mob = Drone.instance()
		mob.position = spawn.position
		emit_signal("spawn_mob", mob)
	
	wave_position += 1
