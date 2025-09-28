extends CharacterBody2D

@export var speed = 25
var screen_size

@export var max_health = 100
@export var health = 100

@export var attack_range = 25
@export var attack_damage = 5
@export var attack_cooldown = 2.0

@export var blood_puddle_scene: PackedScene  # assign BloodPuddle.tscn in Inspector

var cooldown_timer = 0.0
var target: Node = null

func _ready():
	screen_size = get_viewport_rect().size
	print(target)

func take_damage(amount):
	health -= amount
	print("Enemy hit! Health now: ", health)
	if health <= 0:
		spawn_blood()
		queue_free()  # destroy enemy when dead

func spawn_blood():
	if not blood_puddle_scene:
		return
	var puddle = blood_puddle_scene.instantiate()
	get_parent().add_child(puddle)
	puddle.position = global_position
	
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
		
	
