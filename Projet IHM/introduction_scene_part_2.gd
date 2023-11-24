extends Node3D


func _on_timer_timeout():
	$AnimationPlayer.play("ships_movment")
	$Timer2.start()

func _on_timer_2_timeout():
	$AnimationPlayer.play("ships_stops")

func _on_timer_3_timeout():
	get_tree().change_scene_to_file("res://main.tscn");
