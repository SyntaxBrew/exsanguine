extends CharacterBody2D
class_name Player
signal HealthChanged

@export var health_label: Label

@export var speed = 50
var screen_size
@export var projectile_scene: PackedScene
@export var max_health = 100
@export var health = 100

@export var shield_duration = 10
var shield_timer = 0
var shield_active = false

func _ready():
	screen_size = get_viewport_rect().size
	print("Player Loaded")



func _on_damage_timer_timeout():
	health -= 1
	

func shoot_projectile():
	if health > 1:
		health -= 1
		if not projectile_scene:
			return

		var projectile = projectile_scene.instantiate()
		get_parent().add_child(projectile)
		projectile.position = global_position

		# direction vector toward mouse
		projectile.direction = (get_global_mouse_position() - global_position).normalized()
		
		# rotate the projectile to face that direction
		projectile.rotation = projectile.direction.angle()

func heal(amount):
	health += amount
	if health > max_health:
		health = max_health
		
func activate_shield():
	if health > 20:
		health -= 20
		shield_active = true
		$Shield.visible = true
		
func take_damage(amount):
	if shield_active:
		return
	health -= amount

func _process(delta):
	if shield_active:
		shield_timer += delta
		if shield_timer >= shield_duration:
			shield_active = false
			$Shield.visible = false
			shield_timer = 0
		
	HealthChanged.emit()
	
	if Input.is_action_just_pressed("shoot"):
		shoot_projectile()
	if Input.is_action_just_pressed("shield") and not shield_active:
		activate_shield()
	
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
