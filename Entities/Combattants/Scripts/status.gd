class_name Status extends Node

var status_name: String = "Missing String"
var status_type: Constants.StatusType

var amount: int
var turn_duration := 1

var icon_texture: Texture2D


func create(data: StatusPojo) -> void:
	pass



class StatusPojo:
	var status_name: String
	var status_type: Constants.StatusType
	var amount: int
	var turn_duration: int
	var icon_texture: Texture2D
	
	static func of(_status_name: String, _status_type: Constants.StatusType, _amount: int, _turn_duration: int, _icon_texture:Texture2D) -> StatusPojo:
		var i := StatusPojo.new()
		
		i.status_name = _status_name
		i.status_type = _status_type
		i.amount = _amount
		i.turn_duration = _turn_duration
		i.icon_texture = _icon_texture
		
		return i
	
