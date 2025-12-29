class_name Effects extends Node

var icon: Texture2D

var effect_name: String = "Missing String"

var effect_type: Constants.EffectType 
var stat_type: Constants.StatType
var buff_type: Constants.BuffType
var buff_amount_type: Constants.BuffAmountType

var animation: PackedScene

var amount := 1
var turn_duration := 1

var status_type: Constants.StatusType

func create(data: Effect) -> void:
	effect_type = data.effect_type
	effect_name = data.name
	amount = data.amount
	status_type = data.status
	stat_type = data.stats_type
	buff_type = data.buff_type
	buff_amount_type = data.buff_amount_type
	turn_duration = data.turn_duration
	animation = data.animation
	icon = data.icon


func apply_to_target(target: Combattant) -> void:
	match effect_type:
		Constants.EffectType.HEAL:
			target.heal_hp(amount)
		Constants.EffectType.STATUS:
			target.add_status(Status.StatusPojo.of(effect_name, status_type, amount, turn_duration, icon))
		Constants.EffectType.CLEAR_STATUS:
			target.clear_status(status_type)
		Constants.EffectType.BUFF:
			target.add_buff(Buffs.BuffPojo.of(stat_type, buff_type, buff_amount_type, amount, turn_duration, animation, icon))
		_:
			return
			
