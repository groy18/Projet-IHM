extends Node3D

@export var sith_trooper_scene: PackedScene;
@export var sith_knights_scene: PackedScene;

var sith_troopers = [];
var sith_trooper;
var sith_knights;

var power_mode = false;
var info = true;
var force = preload("res://ForceProjection.tscn")
var wave = false;
var guard_position = false;
var player_position;

var sith_knights_spawn_location
var sith_trooper_spawn_location

# Placement des sith troopers et du sith knight
func _on_sith_trooper_timer_timeout():	
	
	if wave == false :
	# Premier groupe de sith troopers
		for i in range (3) :
			
			sith_trooper = sith_trooper_scene.instantiate()
			sith_trooper_spawn_location = get_node("SpawnPath/SpawnLocation")				
			sith_trooper_spawn_location.progress_ratio = randf()
			player_position = $Player.position
			sith_trooper.initialize(Vector3(27.787+i, 0.74, -5.835), player_position)
			sith_troopers.append(sith_trooper);
			add_child(sith_trooper);
		
		# Deuxième groupe de sith troopers	
		for i in range (3) :
			
			sith_trooper = sith_trooper_scene.instantiate()
			sith_trooper_spawn_location = get_node("SpawnPath/SpawnLocation")	
			sith_trooper_spawn_location.progress_ratio = randf()
			player_position = $Player.position
			sith_trooper.initialize(Vector3(-7.135+i, 0.74, -12.627), player_position)
			sith_troopers.append(sith_trooper);
			add_child(sith_trooper);
		
		
		# Troisième groupe de sith troopers	
		for i in range (3) :
			
			sith_trooper = sith_trooper_scene.instantiate()
			sith_trooper_spawn_location = get_node("SpawnPath/SpawnLocation")	
			sith_trooper_spawn_location.progress_ratio = randf()
			player_position = $Player.position
			sith_trooper.initialize(Vector3(16.61+i, 0.829, -23.72), player_position)
			sith_troopers.append(sith_trooper);
			add_child(sith_trooper);
		
		
		# Quatrième groupe de sith troopers	
		for i in range (3) :
			
			sith_trooper = sith_trooper_scene.instantiate()
			sith_trooper_spawn_location = get_node("SpawnPath/SpawnLocation")	
			sith_trooper_spawn_location.progress_ratio = randf()
			player_position = $Player.position
			sith_trooper.initialize(Vector3(-23.87+i, 0.829, -3.729), player_position)
			sith_troopers.append(sith_trooper);
			add_child(sith_trooper);
		
		# Quatrième groupe de sith_troopers	
		for i in range (3) :	
			
			sith_trooper = sith_trooper_scene.instantiate()
			sith_trooper_spawn_location = get_node("SpawnPath/SpawnLocation")	
			sith_trooper_spawn_location.progress_ratio = randf()
			player_position = $Player.position
			sith_trooper.initialize(Vector3(29.141+i, 0.829, 14.592), player_position)
			sith_troopers.append(sith_trooper);
			add_child(sith_trooper);
					
		sith_knights = sith_knights_scene.instantiate()
		sith_knights_spawn_location = get_node("SpawnPath/SpawnLocation")	
		sith_knights_spawn_location.progress_ratio = randf()
		player_position = $Player.position
			
		sith_knights.initialize(Vector3(5.581, 0.74, -16.6), player_position)
		
		sith_troopers.append(sith_knights);
		
		add_child(sith_knights);
		
		wave = true;
		$MovingTimer.start();
		$Sith_Trooper_Timer.stop();


func _on_timer_timeout():
	for i in sith_troopers :
		i.move($Player.position)

# Quand le joueur est touché
func _on_player_body_entered():
	if guard_position == true:
		$SaberAttack.play();
		$Player/AnimationGuard.play("counter_attack");
		$Player/Node3D/Control/HealthBar.value = $Player/Node3D/Control/HealthBar.value -0.02;			
	else:
		$Player/Node3D/Control/HealthBar.value = $Player/Node3D/Control/HealthBar.value -4;	
	
	if $Player/Node3D/Control/HealthBar.value <= 0 :
		_on_player_die();

# Quand le joueur n'a plus de vie
func _on_player_die():
	$Player/Node3D/Control/HealthBar.value = 0;
	$PlayerDie.play();
	get_tree().change_scene_to_file("res://Menu_fail.tscn");

func _unhandled_input(event):
	
	if event.is_action_pressed("attack") and guard_position == false:
		$SaberTimer.start()
		$Player/AttackAnimation.play("Attack")
	
	if event.is_action_pressed("attack_2") and guard_position == false:
		$SaberTimer2.start()
		$Player/AttackAnimation.play("Attack_animation_2")
		
		
	if event.is_action_pressed("guard_position"):
		if guard_position == false:
			guard_position = true;
			$Player/AnimationGuard.play("guard_on");
		else:
			guard_position = false;
			$Player/AnimationGuard.play("guard_off");

# Lorsque le joueur attaque un sith trooper ou le sith knight
func _on_player_attack(sith_trooper):
	
	$SaberAttack.play();
	
	if !$SaberTimer.is_stopped() or !$SaberTimer2.is_stopped() :
		sith_trooper.life = sith_trooper.life - 80;	
		
	if sith_trooper.life <=0 and guard_position== false:
		$Sith_Trooper_Die.play()
		sith_troopers.erase(sith_trooper);
		sith_trooper.queue_free();
		$Player/Node3D/Control/HealthBar.value = $Player/Node3D/Control/HealthBar.value +20;	

	if sith_troopers.size()==0:
		get_tree().change_scene_to_file("res://Menu_fin.tscn");

# Utilisation de la force
func _on_player_force():
	var f = force.instantiate();
	f.start($Player.global_position);
	add_child(f);


func _on_objectif_timer_timeout():
	$Objectif.hide();
