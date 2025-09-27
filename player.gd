extends CharacterBody2D

@export var speed = 200
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	print("Player Loaded")
	
func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		
	direction = direction.normalized()
	var velocity = direction * speed * delta
	position = (position + velocity).clamp(Vector2.ZERO, screen_size)
	
	
