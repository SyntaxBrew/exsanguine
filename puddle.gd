extends Area2D

@export var heal_amount := 10  # amount of health restored

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	# Only heal player
	if body.has_method("heal"):
		body.heal(heal_amount)
		queue_free()  # remove puddle after healing
