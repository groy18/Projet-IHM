extends CharacterBody3D

@export var min_speed = 4
@export var max_speed = 6

var random_speed;
var direction = Vector3(80,0,0);
var life = 240;
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

# Déplacement du sith knight
func move(player_position):
	look_at_from_position(self.position, player_position,Vector3.UP)		
	random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

#Lorsque le joueur entre dans la zone d'attaque
func _on_player_detector_body_entered(body):	
	player_in_zone = true;
	$AnimationPlayer.play("saber_1")
	$Timer.start()


func _on_timer_timeout():	
	if player_in_zone == true:
		$AnimationPlayer.play("saber_1")

#Lorsque le joueur quitte la zone d'attaque
func _on_player_detector_body_exited(body):
	$Timer.stop()
	player_in_zone=false;
