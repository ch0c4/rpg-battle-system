extends Node2D

@export var bounce_height := 10.0
@export var bounce_duration := 0.6

@onready var arrow_sprite: Sprite2D = $ArrowSprite


func _ready() -> void:
	var start_y := arrow_sprite.position.y
	
	var tween := create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(arrow_sprite, "position:y", start_y - bounce_height, bounce_duration / 2)
	tween.tween_property(arrow_sprite, "position:y", start_y, bounce_duration / 2)