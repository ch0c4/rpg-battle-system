class_name Combattant extends Node2D

@export var info: Fighter

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shadow: Sprite2D = $Shadow
@onready var actions: Node = $Actions
@onready var status: Node = $Status
@onready var buffs: Node = $Buffs

var current_hp := 1
var max_hp := 1

var current_mana := 1
var max_mana := 1

var min_attack := 1
var max_attack := 1

var protection := 0
var speed := 1

var fixed_position := Vector2.ZERO


func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	fixed_position = shadow.position


func _on_animation_finished(_anim_name: StringName) -> void:
	animation_player.play("idle")


func get_actions() -> Array:
	return actions.get_children()


func get_status() -> Array:
	return status.get_children()


func get_buffs() -> Array:
	return buffs.get_children()


func get_initiative() -> int:
	return (randi() % 6 + 1) + info.speed


func apply_buff(starting_amount: int, stat_type: Constants.StatType) -> int:
	var result := starting_amount
	
	for buff in get_buffs():
		pass
		
	
	return result
