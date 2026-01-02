class_name Combat extends CanvasLayer

@onready var info_label: Label = %InfoLabel

@onready var arena: Arena = %Arena
@onready var monster_list_container := %MonsterListContainer
@onready var hero_list_container := %HeroListContainer

@onready var action_button := %ActionTextureButton
@onready var item_button := %ItemsTextureButton
@onready var run_button := %RunTextureButton

@onready var hero_selected := GameState.hero_selected
@onready var monster_selected := GameState.monster_selected

var monster_element_reference: PackedScene = load("res://HUD/monster_element.tscn")
var player_element_reference: PackedScene = load("res://HUD/hero_element.tscn")

var initiative_order: Array[Combattant] = []

var turn_count := 0
var can_interact := false


func _ready() -> void:
	turn_count = 0
	prepare_arena()
	prepare_ui()
	start_combat()



func _unhandled_input(event: InputEvent) -> void:
	pass



func start_combat() -> void:
	turn_count += 1
	info_label.text = str("Turn ", turn_count, " starts!")
	
	await get_tree().create_timer(1.5).timeout
	
	initiative_order.append_array(arena.combattants)
	initiative_order.sort_custom(func(c1, c2):
		if c1.get_initiative() > c2.get_initiative():
			return true
		return false 
	)
	
	go_to_next_combattant()


func go_to_next_combattant() -> void:
	var current_combattant: Combattant = initiative_order.pop_front()
	current_combattant.select()
	if current_combattant.player_type == Constants.PlayerType.PLAYER:
		can_interact = true
	
	action_button.show()
		

func prepare_arena() -> void:
	var arena_data: Array[Arena.ArenaPOJO] = []
	for h: String in GameState.hero_selected:
		var a := Arena.ArenaPOJO.new()
		a.fighter_name = h
		a.is_hero = true
		arena_data.append(a)
	
	for m: String in GameState.monster_selected:
		var a := Arena.ArenaPOJO.new()
		a.fighter_name = m
		a.is_hero = false
		arena_data.append(a)
	
	arena.create(arena_data)


func prepare_ui() -> void:
	action_button.hide()
	item_button.hide()
	run_button.hide()

	for m: String in GameState.monster_selected:
		var e: Node = monster_element_reference.instantiate()
		e.create(m)
		monster_list_container.add_child(e)
	
	for c: Combattant in arena.combattants:
		if c.player_type == Constants.PlayerType.PLAYER:
			var e: Node = player_element_reference.instantiate()
			e.create(c.info)
			hero_list_container.add_child(e)
			
