extends CharacterBody3D

@onready var head = $head

var current_speed = 5.0

@export var running_speed = 8.0
@export var crouching_speed = 4.0
@export var mouse_sens = 0.067
@export var grav = Vector3(0, -12, 0)

var JUMP_VELOCITY = 4.5




func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
	
	#allows mouse out of being captured
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else: 
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			
			

func _physics_process(delta: float) -> void:
	
	
	if Input.is_action_pressed("crouch"):
		current_speed = crouching_speed
	else:
		current_speed = running_speed
	
	# Add the gravity.
	if not is_on_floor():
		velocity += grav * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
