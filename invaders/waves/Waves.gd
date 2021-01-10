extends Node2D

class_name Waves

export (PackedScene) var Drone

signal spawn_mob

var waves = null

var wave_position = 0
var volley_position = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	waves = load_json("res://waves/waves.json")


func start():
	spawn_volley()


func spawn_volley():
	print("Spawning wave " + str(wave_position) + "-" + str(volley_position))
	var wave = waves[wave_position]
	var volley = wave.vollies[volley_position]
	
	for enemy in volley.enemies:
		var spawn = wave.spawns[enemy.spawn]
		var mob = Drone.instance()
		mob.connect("enemy_killed", self, "check_enemies")
		mob.position.x = spawn.x
		mob.position.y = spawn.y
		emit_signal("spawn_mob", mob)
		
	volley_position += 1
	if volley_position >= wave.vollies.size():
		wave_position += 1
		volley_position = 0

	if wave_position >= waves.size():
		wave_position = 0
		volley_position = 0


# Check to see if there are any enemies left. If not, start the timer
# to spawn the next wave. Otherwise do nothing.
func check_enemies(points):
	# enemy count of 1 means all enemies have been killed 
	# since removing the enemy has been queued
	if get_tree().get_nodes_in_group("Enemies").size() == 1:
		var wave = waves[wave_position]
		var volley = wave.vollies[volley_position]
		$Timer.wait_time = volley.delay
		$Timer.start()


func _on_Timer_timeout():
	spawn_volley()


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
