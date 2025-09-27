extends Node2D

@export var speed := 400
var direction := Vector2.ZERO

func _process(delta):
	position += direction * speed * delta
	# remove if offscreen
	if not get_viewport_rect().has_point(position):
		queue_free()
