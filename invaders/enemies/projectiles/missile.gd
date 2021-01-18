class_name Missile
extends EnemyProjectile

export var dumb_distance = 600

func _ready():
	speed = 500.0
	damage = 20


func _physics_process(delta:float):
	var player = .closest_target()
	if !player:
		return .move(delta)

	var distanceSq = (player.global_position - global_position).length_squared()
	if distanceSq <= dumb_distance * dumb_distance:
		# too close to player, don't adjust direction
		return .move(delta)
		
	var wants_angle = get_angle_to(player.global_position)
	if wants_angle > 0:
		rotation += deg2rad(1)
	else:
		rotation -= deg2rad(1)

	direction = Vector2(cos(rotation), sin(rotation)).normalized()

	.move(delta)
