extends CharacterBody3D

@export var min_speed = 2
@export var max_speed = 4

var random_speed;
var blast = preload("res://blast.tscn")
var direction = Vector3(80,0,0);
var life = 100;
var player_in_zone = false;
var player;

func _physics_process(delta):
	move_and_slide()

func initialize(start_position, player_position):
	
	look_at_from_position(start_position, player_position,Vector3.UP)	
	rotate_y(randf_range(-PI/2,PI/2))
	random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func move(player_position):
	
	look_at_from_position(self.position, player_position,Vector3.UP)
	random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

# Attaque du sith trooper
func shoot(player_position):
	var b = blast.instantiate();
	b.start($Blaster.global_position, player_position);
	$BlasterSound.play()
	get_tree().root.add_child(b);

# Lorsque le joueur entre dans la zone d'attaque du sith trooper
func _on_player_detector_body_entered(body):
	$Timer.start();
	player = body;
	shoot(body.position);

func _on_timer_timeout():
	shoot(player.position)

# Lorsque le joueur quitte la zone d'attaque du sith trooper
func _on_player_detector_body_exited(body):
	$Timer.stop();
