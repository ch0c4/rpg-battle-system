class_name EffectScene extends Node2D

signal animation_finished

func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _on_animation_finished() -> void:
	animation_finished.emit()
	queue_free()
