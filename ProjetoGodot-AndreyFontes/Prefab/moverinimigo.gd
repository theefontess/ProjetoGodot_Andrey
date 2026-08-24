extends CharacterBody3D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var animator = get_node("Crab2/AnimationPlayer")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var inimigomov = global_position.direction_to(player.global_position)
	velocity = inimigomov * 4.0
	look_at(player.global_position, Vector3.UP)
	move_and_slide()
	if is_on_floor():
		animator.play("Walk")
	
