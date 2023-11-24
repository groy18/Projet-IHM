extends Node3D

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://main.tscn");

func _on_timer_timeout():
	$AnimationPlayer.play("camera_movment_1")
	$Timer2.start()


func _on_timer_2_timeout():
	$AnimationPlayer.play("destroyer_movment")
	$Timer3.start()


func _on_timer_3_timeout():
	$Ship_1.show();
	$Ship_2.show();
	$Animation_Ship_1.play("ship_1_movment");
	$Animation_Ship_2.play("ship_2_movment");


func _on_timer_4_timeout():
	get_tree().change_scene_to_file("res://introduction_scene_part_2.tscn");
