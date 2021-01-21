extends Enemy

export (PackedScene) var MissileScene

export var sight_range = 600
export var rotation_speed = 0.01


func _ready():
	speed = 200
	rotation_degrees = 90
	pass


func _process(delta):
	pass


func hit(damage):
	hp -= damage


func fire(delta):
	var missile: Missile = MissileScene.instance()
	missile.global_position = $WeaponPosition.global_position
	missile.direction = Vector2(cos(rotation), sin(rotation))
	missile.rotation = rotation
	emit_signal("enemy_fired", missile)
	$AttackTimer.start()


func move(delta):
	var player = closest_target()

	var wants_angle = get_angle_to(player.global_position)
	if wants_angle > 0:
		rotation += deg2rad(1)
	else:
		rotation -= deg2rad(1)

	direction = Vector2(cos(rotation), sin(rotation)).normalized()

	var distance = (player.global_position - global_position).length()
	if distance > sight_range:
		.move(delta)
		
	if distance < sight_range/3:
		direction *= -1
		.move(delta)


func should_fire() -> bool:
	if !$AttackTimer.is_stopped():
		return false
	
	var player = closest_target()
	var distance = (player.global_position - global_position).length()
	if distance > sight_range:
		return false

	var rotation_vector = Vector2(cos(rotation), sin(rotation))
	var d = (player.position - position).normalized().dot(rotation_vector)
	return d > 0.99
	

func should_die() -> bool:
	return hp <= 0


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func is_on_screen():
	var rect = $Sprite.get_rect()
	rect.position = to_global(rect.position)
	return screen_rect.encloses(rect)
	# return screen_rect.has_point(global_position)
