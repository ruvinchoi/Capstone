extends Control



func _on_testing_pressed():
	print("testing pressed")
	


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
