extends Node

@export var enemy_scene: PackedScene

func _ready():
	$EnemySpawnTimer.start()
	
func _process(delta):
	if $Player.health <= 0:
		get_tree().quit(0)
	$HUD/Health.text = "Health: " + str($Player.health)
	$HUD/ProgressBar.value = $Player.health * 100 / $Player.max_health
	
func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.target = $Player
	enemy.position = $EnemySpawnLocation.position
	add_child(enemy)

func _on_enemy_spawn_timer_timeout():
	spawn_enemy()
