class_name Arena extends Node2D


var damage_label_reference: PackedScene = load("res://Entities/DamageLabel/damage_label.tscn")


@onready var hero_up: Marker2D = $Heroes/HeroUp
@onready var hero_central: Marker2D = $Heroes/HeroCentral
@onready var hero_down: Marker2D = $Heroes/HeroDown

@onready var monster_up: Marker2D = $Monsters/MonsterUp
@onready var monster_central: Marker2D = $Monsters/MonsterCentral
@onready var monster_down: Marker2D = $Monsters/MonsterDown


func _ready() -> void:
	Events.create_damage_label.connect(create_damage_label)


func get_combattants() -> Array[Combattant]:
	var combattants: Array[Combattant] = []
	if hero_up.get_children().size() > 0:
		combattants.append(hero_up.get_child(0) as Combattant)
	
	if hero_central.get_children().size() > 0:
		combattants.append(hero_central.get_child(0) as Combattant)
	
	if hero_down.get_children().size() > 0:
		combattants.append(hero_down.get_child(0) as Combattant)
	
	if monster_up.get_children().size() > 0:
		combattants.append(monster_up.get_child(0) as Combattant)
	
	if monster_central.get_children().size() > 0:
		combattants.append(monster_central.get_child(0) as Combattant)
	
	if monster_down.get_children().size() > 0:
		combattants.append(monster_down.get_child(0) as Combattant)
	
	return combattants


func create_damage_label(damage: int, starting_position: Vector2, color: Color) -> void:
	var new_damage_effect: DamageLabel = damage_label_reference.instantiate()
	new_damage_effect.global_position = starting_position
	new_damage_effect.set_number(damage, color)
	add_child(new_damage_effect)
	
		