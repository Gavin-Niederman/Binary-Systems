extends Node3D

var fireball_info = preload("res://configs/projectiles/fireball.tres")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("forward"):
		$"ProjectileSpawner".spawn_projectile(fireball_info, Vector3(1, 0, 0))
	
