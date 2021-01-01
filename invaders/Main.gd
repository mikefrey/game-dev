extends Node2D

export (PackedScene) var Enemy1

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()


func _process(delta):
	pass


func damage():
	pass # Replace with function body.


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func spawn_enemy():
	$MobSpawnPath/MobSpawnLocation.offset = randi()
	
	var mob = Enemy1.instance()
	add_child(mob)
	mob.add_to_group("Enemies", true)
	mob.connect("enemy_killed", self, "on_enemy_killed")
	
	mob.position = $MobSpawnPath/MobSpawnLocation.position


func on_enemy_killed(points):
	score += points


func _on_StartTimer_timeout():
	$MobTimer.start()

