extends CharacterBody3D


@export var speed: float=5.0
@export var mouse_sensitivity: float=0.003
@export var jump_velocity: float=4.5
@export var rotation_speed: float=3.0

const GRAVITY = 9.8

@onready var spring_arm = $SpringArm3D
var camera_rotation_x := 0.0

@onready var animator = get_node ("Character_Gun/AnimationPlayer") as AnimationPlayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		
		camera_rotation_x -= event.relative.y * mouse_sensitivity
		camera_rotation_x = clamp(camera_rotation_x,deg_to_rad(-80),deg_to_rad(80))
		spring_arm.rotation.x = camera_rotation_x
		
	if event.is_action_pressed("uicancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if event.is_action_pressed("uireturn"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -=GRAVITY * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		animator.play("Jump")
		
		
	var input_dir = Vector2.ZERO
	if is_on_floor():
		
		if Input.is_action_pressed("move_forward"):
			input_dir.y += 1
			animator.play("Run")
			
		elif Input.is_action_pressed("move_back"):
			input_dir.y -= 1
			animator.play("Run")
		else:
			animator.play("Idle")
			
		if Input.is_action_pressed("move_left"):
			input_dir.x += 1
			animator.play("Run")
			
		elif Input.is_action_pressed("move_right"):
			input_dir.x -= 1
			animator.play("Run")
			
		input_dir = input_dir.normalized()
		
		if Input.is_action_pressed("atirar"):
			animator.play("Idle_Shoot")
			
			
		var direction = (transform.basis * Vector3(input_dir.x , 0 , input_dir.y)).normalized()
		
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = move_toward(velocity.x, 0 ,speed)
			velocity.z = move_toward(velocity.z, 0 ,speed)
		
	move_and_slide()
