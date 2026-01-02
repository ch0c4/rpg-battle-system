class_name Arena extends Node2D


var damage_label_reference: PackedScene = load("res://Entities/DamageLabel/damage_label.tscn")


@onready var hero_up: Marker2D = $Heroes/HeroUp
@onready var hero_central: Marker2D = $Heroes/HeroCentral
@onready var hero_down: Marker2D = $Heroes/HeroDown

@onready var monster_up: Marker2D = $Monsters/MonsterUp
@onready var monster_central: Marker2D = $Monsters/MonsterCentral
@onready var monster_down: Marker2D = $Monsters/MonsterDown

var combattants: Array[Combattant] = []


func create(data: Array[ArenaPOJO]) -> void:
	var heroes: Array = data.filter(func(d): return d.is_hero)
	var monsters: Array = data.filter(func(d): return !d.is_hero)
	
	if heroes.size() == 1:
		var hero: Combattant = Database.heroes[heroes[0].fighter_name].instantiate()
		hero_central.add_child(hero)
	
	elif heroes.size() == 2:
		var hero_c: Combattant = Database.heroes[heroes[0].fighter_name].instantiate()
		hero_central.add_child(hero_c)
		var hero_d: Combattant = Database.heroes[heroes[1].fighter_name].instantiate()
		hero_down.add_child(hero_d)
	
	else:
		var hero_c: Combattant = Database.heroes[heroes[0].fighter_name].instantiate()
		hero_central.add_child(hero_c)
		var hero_d: Combattant = Database.heroes[heroes[1].fighter_name].instantiate()
		hero_down.add_child(hero_d)
		var hero_u: Combattant = Database.heroes[heroes[2].fighter_name].instantiate()
		hero_up.add_child(hero_u)
	
	if monsters.size() == 1:
		var monster: Combattant = Database.monsters[monsters[0].fighter_name].instantiate()
		monster_central.add_child(monster)
	
	elif monsters.size() == 2:
		var monster_c: Combattant = Database.monsters[monsters[0].fighter_name].instantiate()
		monster_central.add_child(monster_c)
		var monster_d: Combattant = Database.monsters[monsters[1].fighter_name].instantiate()
		monster_down.add_child(monster_d)
	
	else:
		var monster_c: Combattant = Database.monsters[monsters[0].fighter_name].instantiate()
		monster_central.add_child(monster_c)
		var monster_d: Combattant = Database.monsters[monsters[1].fighter_name].instantiate()
		monster_down.add_child(monster_d)
		var monster_u: Combattant = Database.monsters[monsters[2].fighter_name].instantiate()
		monster_up.add_child(monster_u)


func _ready() -> void:
	Events.create_damage_label.connect(create_damage_label)
	combattants = get_combattants()


func create_damage_label(damage: int, starting_position: Vector2, color: Color) -> void:
	var new_damage_effect: DamageLabel = damage_label_reference.instantiate()
	new_damage_effect.global_position = starting_position
	new_damage_effect.set_number(damage, color)
	add_child(new_damage_effect)


func get_combattants() -> Array[Combattant]:
	var c: Array[Combattant] = []
	if hero_up.get_children().size() > 0:
		c.append(hero_up.get_child(0) as Combattant)
	
	if hero_down.get_children().size() > 0:
		c.append(hero_down.get_child(0) as Combattant)
	
	if hero_central.get_children().size() > 0:
		c.append(hero_central.get_child(0) as Combattant)
	
	if monster_up.get_children().size() > 0:
		c.append(monster_up.get_child(0) as Combattant)
	
	if monster_central.get_children().size() > 0:
		c.append(monster_central.get_child(0) as Combattant)
	
	if monster_down.get_children().size() > 0:
		c.append(monster_down.get_child(0) as Combattant)
	
	return c


func get_initiative() -> void:
	if combattants.size() == 0:
		combattants = get_combattants()
	
	


class ArenaPOJO:
	var fighter_name: String
	var is_hero: bool
	
	static func of(_fighter_name: String, _is_hero: bool) -> ArenaPOJO:
		var a: ArenaPOJO = ArenaPOJO.new()
		a.fighter_name = _fighter_name
		a.is_hero = _is_hero
		return a
		
