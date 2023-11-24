extends RigidBody3D

var speed = 10;

func start(_position):
	$Timer.start()
	position = _position;
	var dir: Vector3 = transform.basis.z
	apply_impulse(dir)
	set_axis_velocity(Vector3(0,0,-80));
	
func _on_timer_timeout():
	queue_free()	
