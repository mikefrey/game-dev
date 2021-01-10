extends Area2D

class_name Player

export (PackedScene) var Bullet

signal hit

const max_speed = 400
const acceleration = 40

const deadzone = 0.2

var velocity = Vector2()
var screen_size
var shields = 100
var energy = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size * 8


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement_vector = process_input()
	
	if movement_vector.y > 0:
		$ThrustParticles.visible = false
	else:
		$ThrustParticles.visible = true
	
	if movement_vector.length() == 0:
		movement_vector = velocity.normalized() * -1
	
	if movement_vector.length() > 1:
		movement_vector = movement_vector.normalized()
		
	velocity += movement_vector * acceleration
	
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
		
	if velocity.length() < 1:
		velocity.x = 0
		velocity.y = 0
		
	global_position += velocity * delta
	global_position.x = clamp(global_position.x, 0, screen_size.x)
	global_position.y = clamp(global_position.y, 0, screen_size.y)


func start(pos):
	position = pos


func process_input():
	var movement_vector = Vector2()
	movement_vector.x = 0
	movement_vector.y = 0
	
	if Input.get_connected_joypads().size() > 0:
		var xAxis = Input.get_joy_axis(0, JOY_AXIS_0)
		var yAxis = Input.get_joy_axis(0, JOY_AXIS_1)
		
		if abs(xAxis) > deadzone:
			movement_vector.x = xAxis
			
		if abs(yAxis) > deadzone:
			movement_vector.y = yAxis
	
	if Input.is_action_pressed("ui_up"):
		movement_vector.y -= 1
	if Input.is_action_pressed("ui_down"):
		movement_vector.y += 1
	if Input.is_action_pressed("ui_right"):
		movement_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		movement_vector.x -= 1
		
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
	
	return movement_vector


func shoot():
	if energy < 2:
		return
	
	var barrels = get_tree().get_nodes_in_group("PlayerBarrel")
	
	for barrel in barrels:
		var b = Bullet.instance()
		owner.add_child(b)
		b.global_transform = barrel.global_transform
		barrel.get_child(0).emitting = true
		
		energy -= 1


func _on_EnergyTimer_timeout():
	energy += 5
	energy = clamp(energy, 0, 100)
