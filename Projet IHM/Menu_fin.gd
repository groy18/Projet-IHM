extends Node3D

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") :
		$Menu/Buttons.show()
		$Menu/Control.hide()

func _on_replay_pressed():
	get_tree().change_scene_to_file("res://main.tscn");

func _on_cancel_pressed():
	get_tree().free();
