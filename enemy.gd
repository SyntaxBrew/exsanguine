extends CharacterBody2D

@export var speed = 25
var screen_size

@export var max_health = 100
@export var health = 100

@export var attack_range = 25
@export var attack_damage = 5
@export var attack_cooldown = 2.0

var cooldown_timer = 0.0
var target: Node = null

func _ready():
	screen_size = get_viewport_rect().size
	print(target)
	
func _physics_process(delta):
	var change_pos = (target.position - position)
	
	if change_pos != Vector2.ZERO:
		var direction: Vector2 = change_pos.normalized()
		var new_velocity = direction * speed
		
		if new_velocity.x != 0:
			$AnimatedSprite2D.flip_h = new_velocity.x < 0
			
		velocity = new_velocity
		move_and_slide()
		
func is_player_in_range():
	return (target.position - position).length() <= attack_range

func _process(delta):
	cooldown_timer += delta
	if cooldown_timer >= attack_cooldown:
		cooldown_timer = 0
		if is_player_in_range():
			target.health -= attack_damage
		
	
