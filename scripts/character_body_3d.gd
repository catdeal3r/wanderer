extends CharacterBody3D

const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003
const BOB_FREQ = 2.0
const BOB_AMP = 0.08

var delta_g = 0.0
var bob = 0.0
var mouse_captured = false
var jumping = false
var speed = 2.0
var sprint_enabled = true
var sprint_counter = 0.0

@onready var head = $Head
@onready var camera = $Head/HeadCamera3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true
	
func _unhandled_input(event: InputEvent) -> void:
	# Handle rotation
	if event is InputEventMouseMotion and mouse_captured:
		# delta added for randomness
		head.rotate_y(-event.relative.x * SENSITIVITY + sin(delta_g) / 2)
		camera.rotate_x(-event.relative.y * SENSITIVITY + sin(delta_g) / 2)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(60))
	
	if Input.is_action_just_pressed("unlock_mouse") and mouse_captured:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_captured = false
	elif Input.is_action_just_pressed("unlock_mouse") and not mouse_captured:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		mouse_captured = true

func _physics_process(delta: float) -> void:
	delta_g = delta
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		$Steps.stop()

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumping = true
		
	if jumping and is_on_floor():
		jumping = false
		$Steps.play()
		$JumpLanding.play(0.5)
		
	# Handle sprinting.
	if Input.is_action_pressed("sprint") and sprint_enabled:
		speed = 4.0
		sprint_counter += delta
		$Steps.pitch_scale = 1.1
		if sprint_counter > 5:
			sprint_enabled = false
			sprint_counter = 0.0
	elif Input.is_action_pressed("crouch") and not Input.is_action_pressed("sprint"):
		speed = 0.5
		$Steps.pitch_scale = 0.9
	else:
		speed = 2.0
		$Steps.pitch_scale = 1
	
	if not sprint_enabled:
		sprint_counter += delta
		if sprint_counter > 3:
			sprint_enabled = true
			sprint_counter = 0.0
		
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "forward", "backwards")
	var direction: Vector3 = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			$Steps.play(1.0)
			
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 2.0)
		
	bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(bob)
	
	move_and_slide()

func _headbob(bob) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(bob * BOB_FREQ) * BOB_AMP
	pos.x = sin(bob * BOB_FREQ) * BOB_AMP
	return pos
