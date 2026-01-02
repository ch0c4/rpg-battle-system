extends Control

@onready var hero_list := $VBoxContainer/HeroList
@onready var monster_list := $VBoxContainer/MonsterList

var hero_selected: Array = []
var monster_selected: Array = []

func toggle_hero(hero_name: String) -> void:
	if hero_selected.has(hero_name):
		hero_selected = hero_selected.filter(func(h): return h != hero_name)
	elif hero_selected.size() < 3:
		hero_selected.append(hero_name)

func toggle_monster(monster_name: String) -> void:
	if monster_selected.has(monster_name):
		monster_selected = monster_selected.filter(func(m): return m != monster_name)
	elif monster_selected.size() < 3:
		monster_selected.append(monster_name) 


func _on_brom_pressed() -> void:
	toggle_hero("Brom")


func _on_elowen_pressed() -> void:
	toggle_hero("Elowen")


func _on_liora_pressed() -> void:
	toggle_hero("Liora")


func _on_nymor_pressed() -> void:
	toggle_hero("Nymor")


func _on_ragnar_pressed() -> void:
	toggle_hero("Ragnar")


func _on_vaelis_pressed() -> void:
	toggle_hero("Vaelis")


func _on_bat_pressed() -> void:
	toggle_monster("Bat")


func _on_boar_pressed() -> void:
	toggle_monster("Boar")


func _on_dino_pressed() -> void:
	toggle_monster("Dino")


func _on_dragon_pressed() -> void:
	toggle_monster("Dragon")


func _on_ghost_pressed() -> void:
	toggle_monster("Ghost")


func _on_giant_pressed() -> void:
	toggle_monster("Giant")


func _on_mimic_pressed() -> void:
	toggle_monster("Mimic")


func _on_mushroom_pressed() -> void:
	toggle_monster("Mushroom")


func _on_reptile_pressed() -> void:
	toggle_monster("Reptile")


func _on_slime_pressed() -> void:
	toggle_monster("Slime")


func _on_snake_pressed() -> void:
	toggle_monster("Snake")


func _on_start_pressed() -> void:
	if hero_selected.size() == 0 or monster_selected.size() == 0:
		return
	
	GameState.hero_selected = hero_selected
	GameState.monster_selected = monster_selected
	
	get_tree().change_scene_to_file("res://Game/combat.tscn")
	
	
