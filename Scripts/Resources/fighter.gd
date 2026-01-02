class_name Fighter extends Resource

@export var name: String
@export var faceset: Texture2D

@export var player_type: Constants.PlayerType

@export var min_attack: int
@export var max_attack: int
@export var speed: int
@export var protection: int
@export var max_hp: int
@export var max_mana: int

@export var actions: Array[Action]


func get_initiative() -> int:
	return (randi() % 6 + 1) + speed
	