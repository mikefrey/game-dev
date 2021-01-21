extends Node2D

signal victory
signal defeat

onready var hud = $HUD
onready var player = $ShipA
onready var startTimer = $StartTimer
onready var startPosition = $StartPosition
onready var waves = $Waves

var score := 0


func _process(delta):	
	if player:
		$HUD.set_energy(player.energy)
		$HUD.set_shields(player.shields)


func damage():
	pass # Replace with function body.


func new_game():
	score = 0
	player.start(startPosition.position)
	startTimer.start()
	hud.visible = true


func _on_StartTimer_timeout():
	waves.start()


func _on_spawn_mob(mob):
	add_child(mob)
	mob.add_to_group("Enemies", true)
	mob.connect("enemy_killed", self, "on_enemy_killed")
	mob.connect("enemy_fired", self, "on_enemy_fired")


func on_enemy_killed(points: int):
	score += points
	$HUD.set_score(score)


func on_enemy_fired(projectile: EnemyProjectile):
	add_child(projectile)


func _on_Player_died():
	emit_signal("defeat")

func _on_Waves_victory():
	emit_signal("victory")
