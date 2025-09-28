extends Node

@export var enemy_scene: PackedScene

func _ready():
	$EnemySpawnTimer.start()
	
func _process(delta):
	if $Player.health <= 0:
		$HUD/ColorRect.visible = true
		$HUD/Health.visible = false
		$HUD/ProgressBar.visible = false
		
	$HUD/Health.text = str($Player.health) + "/" + str($Player.max_health)
	$HUD/ProgressBar.value = $Player.health * 100 / $Player.max_health

func restart():
	get_tree().reload_current_scene()

func quit():
	get_tree().quit(0)
	
func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	enemy.target = $Player
	enemy.position = $EnemySpawnLocation.position
	add_child(enemy)

func _on_enemy_spawn_timer_timeout():
	spawn_enemy()
