extends Node3D

@onready var collider: RigidBody3D = $"PlayerCollider"
@onready var camera: Camera3D = $"Camera3D"

var velocity: Vector3
var view_vector: Vector3 = Vector3(1.0, 0, 0)

var movement_vector: Vector2 = Vector2(0, 0)

@export var movement_speed: float = 10;
@export var ground_acceleration: float = 0.5;

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	
	var new_movement_vec = Vector2(
		Input.get_action_strength("left") - Input.get_action_strength("right"),
		Input.get_action_strength("forward") - Input.get_action_strength("back")
	)
	movement_vector = new_movement_vec.normalized()
	
	if event is InputEventMouseMotion:
		var delta_x = event.relative.x
		var delta_y = event.relative.y
		
		var rot = quaternion.get_euler()
		rot.y += -delta_x / 1000
		quaternion = Quaternion.from_euler(rot)
		
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else: 
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func vec2_to_vec3(vec2: Vector2) -> Vector3:
	return Vector3(vec2.x, 0, vec2.y)

func _physics_process(delta: float) -> void:
	var desired_movement = vec2_to_vec3(movement_vector.rotated(-quaternion.get_euler().y))
	var horizontal_velocity = Vector3(view_vector.x, 0, view_vector.z)
	
	# no grounded check yet
	var movement = velocity.lerp(desired_movement * movement_speed, ground_acceleration * delta)

	position += movement
	
	
