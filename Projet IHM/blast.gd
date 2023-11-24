extends CharacterBody3D

var speed = 10;

func start(_position, player_position):
	
	look_at_from_position(_position, player_position, Vector3.UP)
	velocity = Vector3.FORWARD * speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func _on_visibility_notifier_screen_exited():
	queue_free()

func _physics_process(delta):
	var physic = move_and_collide(velocity*delta);
