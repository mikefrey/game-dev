extends Node2D

export (PackedScene) var Drone

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()


func _process(delta):
	var bg_pos = $Background.region_rect.position.y - 10
	if bg_pos <= 0:
		bg_pos += 768
	$Background.region_rect.position.y = bg_pos
	
	$HUD.set_energy($Player.energy)


func damage():
	pass # Replace with function body.


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func spawn_enemy():
	return
	$MobSpawnPath/MobSpawnLocation.offset = randi()
	
	var mob = Drone.instance()
	add_child(mob)
	mob.add_to_group("Enemies", true)
	mob.connect("enemy_killed", self, "on_enemy_killed")
	
	mob.position = $MobSpawnPath/MobSpawnLocation.position


func on_enemy_killed(points):
	score += points
	$HUD.set_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()



func _on_spawn_mob(mob):
	add_child(mob)
	mob.add_to_group("Enemies", true)
	mob.connect("enemy_killed", self, "on_enemy_killed")
