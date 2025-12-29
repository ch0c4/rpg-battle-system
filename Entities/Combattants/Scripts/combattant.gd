class_name Combattant extends Node2D

signal combattant_hp_changed(current_hp: int, max_hp: int)
signal status_changed
signal buff_changed

var status_reference: PackedScene = load("res://Entities/Stats/status.tscn")
var action_reference: PackedScene = load("res://Entities/Stats/action.tscn")
var buffs_reference: PackedScene = load("res://Entities/Stats/buffs.tscn")

@export var info: Fighter

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shadow: Sprite2D = $Shadow
@onready var actions: Node = $Actions
@onready var status: Node = $Status
@onready var buffs: Node = $Buffs

var combattant_name: String
var faceset: Texture2D

var player_type: Constants.PlayerType

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
	
	combattant_name = info.name
	faceset = info.faceset
	player_type = info.player_type
	max_hp = info.max_hp
	current_hp = info.max_hp
	min_attack = info.min_attack
	max_attack = info.max_attack
	speed = info.speed
	protection = info.protection
	
	for a: Action in info.actions:
		var new_action: Actions = action_reference.instantiate()
		new_action.create(a)
		actions.add_child(new_action)


func _on_animation_finished(_anim_name: StringName) -> void:
	animation_player.play("idle")


func get_initiative() -> int:
	return (randi() % 6 + 1) + info.speed


func get_actions() -> Array:
	return actions.get_children()


func get_status() -> Array:
	return status.get_children()


func get_buffs() -> Array:
	return buffs.get_children()


func get_maximum_attack() -> int:
	return max(1, apply_buff(max_attack, Constants.StatType.ATTACK))


func get_minimum_attack() -> int:
	return max(1, apply_buff(min_attack, Constants.StatType.ATTACK))


func get_protection() -> int:
	return clamp(apply_buff(protection, Constants.StatType.PROTECTION), 0, 99)


func get_speed() -> int:
	return apply_buff(speed, Constants.StatType.SPEED)


func roll_attack_damage() -> int:
	return randi() % (get_maximum_attack() - get_minimum_attack()) + get_minimum_attack()


func inflict_damage(damage: int) -> void:
	if player_type == Constants.PlayerType.PLAYER:
		current_hp = max(-50, current_hp - damage)
		if current_hp <= 0:
			Events.remove_combattant_from_queue.emit(self)
	elif player_type == Constants.PlayerType.ENEMY:
		current_hp = max(0, current_hp - damage)
		if current_hp == 0:
			die()
	Events.create_damage_label.emit(damage, fixed_position, Color("b72c69"))
	combattant_hp_changed.emit(current_hp, max_hp)


func apply_buff(starting_amount: int, stat_type: Constants.StatType) -> int:
	var result := starting_amount
	
	for buff: Buffs in get_buffs():
		if buff.stats_type == stat_type:
			if buff.buff_amount_type == Constants.BuffAmountType.FLAT:
				result += buff.amount
			elif buff.buff_amount_type == Constants.BuffAmountType.PERCENTAGE:
				result += int(float(result) * float(buff.amount) / 100.0)		
	
	return result


func heal_hp(amount: int) -> void:
	current_hp = min(max_hp, current_hp + amount)
	Events.create_damage_label.emit(amount, global_position + Vector2(0, -20), Color("2cb744"))
	combattant_hp_changed.emit(current_hp, max_hp)


func add_status(data: Status.StatusPojo) -> void:
	var new_status: Status = status_reference.instantiate()
	new_status.create(data)
	status.add_child(new_status)
	
	status_changed.emit()


func clear_status(status_type: Constants.StatusType) -> void:
	for s: Status in get_status():
		if s.status_type == status_type:
			s.queue_free()
	
	status_changed.emit()


func add_buff(data: Buffs.BuffPojo) -> void:
	var new_buff: Buffs = buffs_reference.instantiate()
	new_buff.create(data)
	buffs.add_child(new_buff)
	
	buff_changed.emit()


func consume_buffs() -> void:
	for b: Buffs in get_buffs():
		b.consume(fixed_position)
		await get_tree().create_timer(0.01).timeout
	
	buff_changed.emit()


func die() -> void:
	Events.remove_combattant_from_queue.emit(self)
	Events.remove_combattant_ui.emit(self)
	queue_free()