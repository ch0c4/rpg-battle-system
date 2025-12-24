class_name EffectScene extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _on_animation_finished() -> void:
	queue_free()
