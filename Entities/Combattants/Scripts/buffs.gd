class_name Buffs extends Node


var stats_type: Constants.StatType
var stats_name: String = "Missing Stat"

var buff_type: Constants.BuffType
var buff_amount_type: Constants.BuffAmountType

var amount: int = 0
var turn_duration: int = 1

var icon_texture: Texture2D
var effect_scene: EffectAnimation

var animation: PackedScene


func create(data: BuffPojo) -> void:
	stats_type = data.stat_type
	match stats_type:
		Constants.StatType.NONE:
			stats_name = "Missing Stat"
		Constants.StatType.ATTACK:
			stats_name = "ATK"
		Constants.StatType.SPEED:
			stats_name = "SPD"
		Constants.StatType.PROTECTION:
			stats_name = "PROT"
		_:
			return
	
	animation = data.animation
	buff_type = data.buff_type
	buff_amount_type = data.buff_amount_type
	amount = data.amount
	turn_duration = data.turn_duration
	icon_texture = data.icon_texture


func consume(target_position: Vector2) -> void:
	turn_duration -= 1
	if turn_duration <= 0:
		queue_free()
	elif animation != null:
		effect_scene = animation.instantiate() as EffectAnimation
		effect_scene.position = target_position
		get_tree().current_scene.add_child(effect_scene)


func get_description() -> String:
	var result := ""
	result += "+" if amount > 0 else "-"
	result += str(abs(amount))
	if buff_amount_type == Constants.BuffAmountType.PERCENTAGE:
		result += "%"
	
	result += " " + stats_name
	
	if turn_duration != 1:
		result += str(" (", turn_duration, " turns)")
	
	elif turn_duration == 1:
		result += str(" (", turn_duration, " turn)")
	
	return result


class BuffPojo:
	var stat_type: Constants.StatType
	var buff_type: Constants.BuffType
	var buff_amount_type: Constants.BuffAmountType
	var amount: int
	var turn_duration: int
	var animation: PackedScene
	var icon_texture: Texture2D
	
	static func of(_stat_type: Constants.StatType, _buff_type: Constants.BuffType, _buff_amount_type: Constants.BuffAmountType, _amount: int, _turn_duration: int, _animation: PackedScene, _icon_texture: Texture2D) -> BuffPojo:
		var b: BuffPojo = BuffPojo.new()
		b.stat_type = _stat_type
		b.buff_type = _buff_type
		b.buff_amount_type = _buff_amount_type
		b.amount = _amount
		b.turn_duration = _turn_duration
		b.animation = _animation
		b.icon_texture = _icon_texture
		
		return b