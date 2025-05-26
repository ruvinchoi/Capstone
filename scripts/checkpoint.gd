extends Area2D
@onready var sprite_2d = $Sprite2D

func _ready():
	sprite_2d.modulate = Color(0,0,0)
	

func _on_body_entered(body):
	if body.is_in_group("player"):
		sprite_2d.modulate = Color(1,1, 0)
