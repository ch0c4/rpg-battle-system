class_name Buffs extends Node


var stats_type: Constants.StatType
var stats_name: String = "Missing Stat"

var buff_type: Constants.BuffType
var buff_amount_type: Constants.BuffAmountType

var amount: int = 0
var turn_duration: int = 1

var icon_texture: Texture2D
var effect_scene: EffectScene

var animation: PackedScene


func init(data: Effect) -> void:
	stats_type = data.stats_type
	match stats_type:
		Constants.StatType.NONE:
			stats_name = "Missing Stat"
		Constants.StatType.ATTACK:
			stats_name = "ATK"
		Constants.StatType.SPEED:
			stats_name = "SPD"
		Constants.StatType.PROTECTION:
			stats_name = "PROT"
	
	animation = data.animation
	buff_type = data.buff_type
	buff_amount_type = data.buff_amount_type
	amount = data.amount
	turn_duration = data.turn_duration
	icon_texture = data.icon


func consume(target_position: Vector2) -> void:
	turn_duration -= 1
	if turn_duration <= 0:
		queue_free()
	elif animation != null:
		effect_scene = animation.instantiate() as EffectScene
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
	