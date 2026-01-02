extends MarginContainer


@onready var select_button: TextureButton = $HBoxContainer/TextureButton
@onready var current_hp: Label = $HBoxContainer/CurrentHP
@onready var mana: Label = $HBoxContainer/Mana


func create(info: Fighter) -> void:
	$HBoxContainer/HeroName.text = info.name
	$HBoxContainer/CurrentHP.text = str(info.max_hp)
	$HBoxContainer/MaxHP.text = str(info.max_hp)
	$HBoxContainer/Mana.text = str(info.max_mana)


func _ready() -> void:
	unselect()


func unselect() -> void:
	select_button.hide()


func select() -> void:
	select_button.show()


func update_hp(value: int) -> void:
	current_hp.text = str(value)


func update_mana(value: int) -> void:
	mana.text = str(value)