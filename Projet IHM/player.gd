extends CharacterBody3D

@export var main : PackedScene

# Vitesse du personnage
@export var speed = 14

# Acceleration de la vitesse quand le personnage est dans les airs
@export var fall_acceleration = 75
@export var jump_impulse = 16
@export var bounce_impulse = 0

signal areaEntered
signal bodyEntered
signal die
signal force
signal attack(sith_trooper)
var target_velocity = Vector3.ZERO

func _physics_process(delta):
	
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 0.5
	
	if Input.is_action_pressed("move_left"):
		direction.x -= 0.5
		
	if Input.is_action_pressed("move_back"):
		direction.z += 0.5
	
	if Input.is_action_pressed("move_forward"):
		direction.z -= 0.5
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
		
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
	velocity = target_velocity
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	
	move_and_slide()
	
func _unhandled_input(event):
	if event.is_action_pressed("power_mode"):
		force.emit()

# Lorsque le joueur se fait toucher par un blast
func _on_blast_detector_body_entered(body):
	bodyEntered.emit()	
	body.free()

# Lorsque le joueur tombe dans le vide
func _on_area_3d_2_body_entered(body):
	die.emit()

# Lorsque le sabre touche un ennemi
func _on_area_3d_body_entered(body):	
		if body.is_in_group("sith_troopers"):
				attack.emit(body)

# Lorsque le joueur se fait touché par le sabre du sith knight
func _on_saber_body_entered(body):
	bodyEntered.emit()
