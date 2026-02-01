extends Node2D


func _on_pumpkin_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Dialogue.tscn")


func _on_bat_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/BatDialogue.tscn")
