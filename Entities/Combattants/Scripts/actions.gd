class_name Actions extends Node

@onready var effect_node: Node = $Effects

var effect_reference := load("res://Entities/Stats/effects.tscn")

var icon: Texture2D
var action_name := "Missing string"
var action_type: Constants.ActionType
var anim_name: StringName
var damage_percent: int
var target: Constants.ActionTarget

var max_uses := -1
var current_uses := -1

func create(data: Action) -> void:
	var actions: Actions = Actions.new()
	
	actions.icon = data.icon
	actions.action_name = data.name
	actions.action_type = data.action_type
	actions.anim_name = data.anim_name
	actions.target = data.target
	
	if data.damage_percent != null:
		actions.damage_percent = data.damage_percent
	
	if data.effects != null && data.effects.size() > 0:
		for effect in data.effects:
			var new_effect: Node = effect_reference.instantiate()
			new_effect.create(effect)
			effect_node.add_child(new_effect)


func get_effects() -> Array:
	return effect_node.get_children()