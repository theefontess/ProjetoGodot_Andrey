extends CharacterBody3D


@export var speed: float=5.0
@export var mouse_sensitivity: float=0.003
@export var jump_velocity: float=4.5
@export var rotation_speed: float=3.0

const GRAVITY = 9.8

@onready var spring_arm = $SpringArm3D
var camera_rotation_x := 0.0

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
