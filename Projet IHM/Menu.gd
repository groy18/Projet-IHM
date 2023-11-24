extends Node3D

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") :
		$Menu/Buttons.show()
		$Menu/Control.hide()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://introduction_scene.tscn");

func _on_commands_button_pressed():
	$Menu/Buttons/Play.hide();
	$Menu/Buttons/Commands.hide();
	$Menu/Buttons/Quit.hide();
	$Menu/Commands.show();
	$Menu/Buttons/Retour.show();


func _on_retour_pressed():
	$Menu/Buttons/Play.show();
	$Menu/Buttons/Commands.show();
	$Menu/Buttons/Quit.show();
	$Menu/Buttons/Retour.hide();
	$Menu/Commands.hide();


func _on_quit_pressed():
	get_tree().free();
