class_name Projectile
extends RigidBody3D

@export var projectile_info: ProjectileInfo
@export var initial_direction: Vector3

func _ready() -> void:
	$"Sprite3D".texture = projectile_info.texture
	gravity_scale = projectile_info.gravity
	linear_velocity = projectile_info.speed * initial_direction
	
