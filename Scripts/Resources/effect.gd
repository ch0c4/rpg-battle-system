class_name Effect extends Resource


@export var icon: Texture2D

@export var name: String
@export var amount: int

@export var turn_duration: int
@export var stats_type: Constants.StatType
@export var effect_type: Constants.EffectType
@export var status: Constants.StatusType
@export var buff_type: Constants.BuffType
@export var buff_amount_type: Constants.BuffAmountType

@export var animation: PackedScene