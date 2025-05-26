extends Node

var last_location
var player

func _ready():
	player = get_parent().get_node("Player")
	last_location = player.global_position
