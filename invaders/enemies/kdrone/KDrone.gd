extends KEnemy

export (PackedScene) var OrbScene

export var sight_range = 600
export var rotation_speed = 0.01

onready var players = get_tree().get_nodes_in_group("Players")

onready var Wants:Line2D = $Wants
onready var Pointing:Line2D = $Pointing

func _ready():
	velocity = Vector2(0, 100)
	rotation_degrees = 90
	pass


func _process(delta):
	pass


func hit(damage):
	hp -= damage
	if hp <= 0:
		die()


func aim(delta):
	var player = closest_player()
	#look_at(player.global_position)

	var wants_angle = get_angle_to(player.global_position)
	if wants_angle > 0:
		rotation += deg2rad(1)
	else:
		rotation -= deg2rad(1)

	var wants_vector = (player.global_position - global_position).normalized()
	Wants.points = [Vector2.ZERO, wants_vector * 50]
	Wants.global_rotation_degrees = 0


func fire(delta):
	var orb: Orb = OrbScene.instance()
	orb.global_position = $WeaponPosition.global_position
	orb.direction = Vector2(cos(rotation), sin(rotation))
	emit_signal("enemy_fired", orb)
	$AttackTimer.start()
	

func should_aim() -> bool:
	var player = closest_player()
	var distance = (player.global_position - global_position).length()
	return distance < sight_range


func should_fire() -> bool:
	if !$AttackTimer.is_stopped():
		return false
	
	var player = closest_player()
	var rotation_vector = Vector2(cos(rotation), sin(rotation))
	var d = (player.position - position).normalized().dot(rotation_vector)
	return d > 0.99
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func closest_player() -> Node2D:
	return find_closest(players)


func find_closest(nodes:Array) -> Node2D:
	var closest:Node2D = null
	var length := INF

	for n in nodes:
		var dist = (n.position - position).length()
		if dist < length:
			closest = n
			length = dist
	
	return closest
