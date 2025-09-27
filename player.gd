extends CharacterBody2D
class_name Player
signal HealthChanged

@export var health_label: Label

@export var speed = 50
var screen_size
@export var projectile_scene: PackedScene
@export var max_health = 100
@export var health = 100



func _ready():
	screen_size = get_viewport_rect().size
	print("Player Loaded")



func _on_damage_timer_timeout():
	health -= 1
	HealthChanged.emit()

func shoot_projectile():
	if not projectile_scene:
		return

	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	projectile.position = global_position

	# direction vector toward mouse
	projectile.direction = (get_global_mouse_position() - global_position).normalized()
	
	# rotate the projectile to face that direction
	projectile.rotation = projectile.direction.angle()

func _process(delta):
	health_label.text = "Health: " + str(health)
	if Input.is_action_just_pressed("shoot"):
		shoot_projectile()

	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1

	velocity = direction.normalized() * speed
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	move_and_slide()
