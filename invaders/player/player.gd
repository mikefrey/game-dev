class_name Player
extends KinematicBody2D

export (PackedScene) var Bullet

signal hit

const max_speed = 400
const acceleration = 40
const deadzone = 0.2

onready var fireTimer = $FireTimer
onready var energyTimer = $EnergyTimer
onready var thrustParticles = $ThrustParticles
onready var debugLine = $DebugLine
onready var barrelParticles = $BarrelParticles
onready var deathParticles = $DeathParticles
onready var dyingParticles = $DyingParticles

var velocity = Vector2()
var movement_vector = Vector2.ZERO
var screen_size
var shields = 100.0
var energy = 100
var is_dead = false
var firing = false


func _ready():
	screen_size = get_viewport_rect().size


func _physics_process(delta):
	if is_dead: return
	
	var direction = movement_vector
	
	debugLine.points = [Vector2.ZERO, movement_vector*50]
	
	if direction.y > 0:
		thrustParticles.visible = false
	else:
		thrustParticles.visible = true
		
	# Damping
	if direction.length_squared() == 0:
		direction = velocity.normalized() * -1
	
	if direction.length_squared() > 1:
		direction = direction.normalized()
		
	velocity += direction * acceleration
	
	if velocity.length_squared() > max_speed * max_speed:
		velocity = velocity.normalized() * max_speed
		
	if velocity.length_squared() < 2:
		velocity.x = 0
		velocity.y = 0
	
	move_and_collide(velocity * delta)

	global_position.x = clamp(global_position.x, 0, screen_size.x)
	global_position.y = clamp(global_position.y, 0, screen_size.y)

	if (firing):
		shoot()
	

func start(pos):
	position = pos


func _unhandled_input(event):
	
	if event is InputEventJoypadMotion:
		var val = 0
		if abs(event.axis_value) > deadzone:
			val = event.axis_value

		if event.axis == 0:
			movement_vector.x = val		
		elif event.axis == 1:
			movement_vector.y = val
				
	else:
		if event.is_action_pressed("ui_accept"):
			firing = true
			barrelParticles.emitting = true
		if event.is_action_released("ui_accept"):
			firing = false
			barrelParticles.emitting = false


func shoot():
	if is_dead: return
	
	if energy < 2:
		return

	if !fireTimer.is_stopped():
		return

	fireTimer.start()
	
	var barrels = get_tree().get_nodes_in_group("PlayerBarrel")
	
	for barrel in barrels:
		var b = Bullet.instance()
		owner.add_child(b)
		b.global_transform = barrel.global_transform
		
		energy -= 1


func _on_EnergyTimer_timeout():
	if !fireTimer.is_stopped():
		return

	energy += 2
	energy = clamp(energy, 0, 100)


func hit(damage:float):
	if is_dead: return
	shields -= damage
	if shields <= 0:
		die()


func die():
	deathParticles.emitting = true
	is_dead = true
	visible = false
