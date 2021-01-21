class_name Missile
extends EnemyProjectile

export var dumb_distance = 100

onready var sprite = $Sprite
onready var particles = $Particles2D
onready var freeTimer = $FreeTimer
onready var collisionShape = $CollisionShape2D

var is_dumb = false


func _physics_process(delta:float):
	var player = .closest_target()
	if !player:
		return .move(delta)

	if is_dumb:
		# too close to player, don't adjust direction
		return .move(delta)

	var distanceSq = (player.global_position - global_position).length_squared()
	if distanceSq <= dumb_distance * dumb_distance:
		is_dumb = true
		
	var wants_angle = get_angle_to(player.global_position)
	if wants_angle > 0:
		rotation += deg2rad(2)
	else:
		rotation -= deg2rad(2)

	direction = Vector2(cos(rotation), sin(rotation)).normalized()

	.move(delta)


func _die():
	print("die")
	sprite.visible = false
	particles.emitting = false
	collisionShape.set_deferred("disabled", true)
	freeTimer.start()


func _on_FreeTimer_timeout():
	print("Freeing missile ")
	queue_free()
