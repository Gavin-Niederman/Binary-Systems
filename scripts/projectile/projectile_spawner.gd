@icon("res://textures/editor/projectile_spawner.svg")
class_name ProjectileSpawner
extends Node3D

var projectile_template: PackedScene = preload("res://scripts/projectile/projectile.tscn")

func spawn_projectile(info: ProjectileInfo, direction: Vector3):
	var projectile: Projectile = projectile_template.instantiate()
	
	projectile.projectile_info = info
	projectile.initial_direction = direction
	
	add_child(projectile)
