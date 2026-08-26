extends CharacterBody3D

@export var velocidade :=3.0
@export var distancia_perseguicao := 21.0

@onready var player = get_tree().get_first_node_in_group("player")
@onready var animator = get_node("Crab2/AnimationPlayer")
@onready var navigation_agent = $NavigationAgent3D

func _ready():
	add_to_group("enemy")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	if player == null:
		return
	
	var distancia = global_position.distance_to(player.global_position)
	
	if distancia <= distancia_perseguicao:
		perseguir_player()
		animator.play("Walk")
	else:
		animator.play("Idle")
		velocity = Vector3.ZERO
	move_and_slide()
	
func perseguir_player():
	navigation_agent.target_position = player.global_position
	var proxima_posicao = navigation_agent.get_next_path_position()
	var direcao = global_position.direction_to(proxima_posicao)
	velocity = direcao * velocidade
	look_at(Vector3(player.global_position.x, player.global_position.y, player.global_position.z) , Vector3.UP)
	move_and_slide()
	
func _on_tree_entered(body):
	if body.is_in_group('player'):
		animator.play("Bite_Front")
