extends Node

func _ready():
	$DamageTimer.start()
	
func _process(delta):
	$HUD/Health.text = "Health: " + str($Player.health)
	
func _on_damage_timer_timeout() -> void:
	$Player.health -= 1
