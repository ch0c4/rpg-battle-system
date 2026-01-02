extends MarginContainer

func create(monster_name: String) -> void:
	$HBoxContainer/Label.text = monster_name


func _ready() -> void:
	$HBoxContainer/TextureButton.hide()