class_name Action extends Resource

@export var animation: PackedScene

@export var name: String
@export var icon: Texture2D

@export var anim_name: StringName

@export var damage_percent: int

@export var target: Constants.ActionTarget

@export var effect: Array[Effect]


func process() -> void:
	pass