extends Area2D

@export var speed := 400
@export var damage := 10
var direction := Vector2.ZERO

func _ready():
	# Correct Godot 4 syntax for connecting signals
	body_entered.connect(_on_body_entered)

func _process(delta):
	position += direction * speed * delta
	if not get_viewport_rect().has_point(position):
		queue_free()

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
