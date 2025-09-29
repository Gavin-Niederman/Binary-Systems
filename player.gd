extends Node3D

@onready var collider: RigidBody3D = $"PlayerCollider"
@onready var camera: Camera3D = $"Camera3D"

var velocity: Vector3
var view_vector: Vector3 = Vector3(1.0, 0, 0)

@export var movement_speed: float = 10;
@export var ground_acceleration: float = 0.5;

func _physics_process(delta: float) -> void:
	var desired_movement = Vector3(view_vector.x, 0, view_vector.z).normalized()
	var horizontal_velocity = Vector3(view_vector.x, 0, view_vector.z)
	
	# no grounded check yet
	var applied_acceleration = min(ground_acceleration, movement_speed / horizontal_velocity.length())
	var new_velocity = horizontal_velocity.length() + applied_acceleration
	desired_movement += desired_movement * (Vector3(new_velocity, new_velocity, new_velocity))

	var movement = desired_movement
	position += movement
	
	
