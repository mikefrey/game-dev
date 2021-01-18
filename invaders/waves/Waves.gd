extends Node2D

class_name Waves

export (PackedScene) var Drone
export (PackedScene) var Bomber

signal spawn_mob

onready var timer = $Timer
onready var labelTimer = $LabelTimer
onready var characterTimer = $CharacterTimer
onready var label = $Label

var waves = null

var wave_position = -1
var volley_position = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	waves = load_json("res://waves/waves.json")


func start():
	next_wave()


func next_wave():
	wave_position += 1
	volley_position = 0

	if wave_position >= waves.size():
		return show_victory()

	var wave = waves[wave_position]
	label.text = wave.name
	characterTimer.start()


func advance():
	var wave = waves[wave_position]

	volley_position += 1
	if volley_position >= wave.vollies.size():
		return next_wave()

	spawn_volley()


func get_mob(name):
	print("get mob " + name)
	# TODO: don't use string matching
	match name:
		"drone":
			return Drone.instance()
		"bomber":
			return Bomber.instance()


func spawn_volley():
	print("Spawning wave " + str(wave_position) + "-" + str(volley_position))
	var wave = waves[wave_position]
	var volley = wave.vollies[volley_position]
	
	for enemy in volley.enemies:
		var spawn = wave.spawns[enemy.spawn]
		var mob = get_mob(enemy.type)

		mob.connect("enemy_killed", self, "check_enemies")
		mob.position.x = spawn.x
		mob.position.y = spawn.y
		emit_signal("spawn_mob", mob)


# Check if any enemies left. If not, start the timer
# to spawn the next wave. Otherwise do nothing.
func check_enemies(points):
	# enemy count of 1 means all enemies have been killed 
	# since removing the enemy has been queued
	var remaining = get_tree().get_nodes_in_group("Enemies").size()
	if remaining == 1:
		var wave = waves[wave_position]
		var volley = wave.vollies[volley_position]
		timer.wait_time = volley.delay
		timer.start()


func _on_Timer_timeout():
	advance()


func _on_LabelTimer_timeout():
	label.visible_characters = 0
	advance()


func _on_CharacterTimer_timeout():
	label.visible_characters += 1
	if label.visible_characters == label.text.length():
		characterTimer.stop()
		labelTimer.start()


func load_json(path):
	var file = File.new()
	file.open(path, file.READ)
	
	var text = file.get_as_text()
	var data = JSON.parse(text)
	
	if data.error != OK:
		print("[load_json] Error loading json file '" + str(path) + "'.")
		print("\tError: ", data.error)
		print("\tError Line: ", data.error_line)
		print("\tError String: ", data.error_string)
		return null
		
	return data.result


func show_victory():
	label.text = "Victory"
	label.visible_characters = -1
