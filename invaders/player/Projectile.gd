class_name Projectile
extends KinematicBody2D

export (PackedScene) var HitEffect
export var velocity := Vector2(0, -200)
export var damage:int = 10

func _ready():
	pass

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		queue_free()
		$Sprite.visible = false
		show_impact(collision.position, collision.normal)
		
		if collision.collider.has_method("hit"):
			collision.collider.hit(damage)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func show_impact(pos, vec):
	var h = HitEffect.instance()
	h.position = pos
	h.rotate(vec.angle())
	h.emitting = true
	replace_by(h, false)
