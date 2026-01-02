extends Node

const heroes: Dictionary[String, PackedScene] = {
	"Brom": preload("res://Entities/Heroes/Brom/brom.tscn"),
	"Elowen": preload("res://Entities/Heroes/Elowen/elowen.tscn"),
	"Liora": preload("res://Entities/Heroes/Liora/liora.tscn"),
	"Nymor": preload("res://Entities/Heroes/Nymor/nymor.tscn"),
	"Ragnar": preload("res://Entities/Heroes/Ragnar/ragnar.tscn"),
	"Vaelis": preload("res://Entities/Heroes/Vaelis/vaelis.tscn")
}

var monsters: Dictionary[String, PackedScene] = {
	"Bat": preload("res://Entities/Monsters/Bat/bat.tscn"),
	"Boar": preload("res://Entities/Monsters/Boar/boar.tscn"),
	"Dino": preload("res://Entities/Monsters/Dino/dino.tscn"),
	"Dragon": preload("res://Entities/Monsters/Dragon/dragon.tscn"),
	"Ghost": preload("res://Entities/Monsters/Ghost/ghost.tscn"),
	"Mimic": preload("res://Entities/Monsters/Mimic/mimic.tscn"),
	"Mushroom": preload("res://Entities/Monsters/Mushroom/mushroom.tscn"),
	"Reptile": preload("res://Entities/Monsters/Reptile/reptile.tscn"),
	"Slime": preload("res://Entities/Monsters/Slime/slime.tscn"),
	"Snake": preload("res://Entities/Monsters/Snake/snake.tscn")
}
