extends TextureProgressBar

@export var player: Player

func _ready():
	update()

func update():
	value = player.health * 100 / player.max_health
