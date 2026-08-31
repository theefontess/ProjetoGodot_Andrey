extends CharacterBody3D

@export var velocidade :=3.0
@export var distancia_perseguicao := 21.0

@export var vidainimigomax := 100
var vida := vidainimigomax
@onready var barra = $BarraVida/SubViewport/ProgressBar

@onready var player = get_tree().get_first_node_in_group("player")
@onready var animator = get_node("Crab2/AnimationPlayer")
@onready var navigation_agent = $NavigationAgent3D

func _ready():
	add_to_group("enemy")
	vida = vidainimigomax
	barra.max_value = vidainimigomax
	barra.value = vida
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	if vida < 60 :
		$BarraVida.modulate = Color.YELLOW
	if vida < 40 :
		$BarraVida.modulate = Color.RED
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
	
func _on_body_entered(body):
	
	if body.is_in_group('player'):
		animator.play("Bite_Front")
		
func receber_dano(dano):
	vida -=dano
	vida = clamp(vida , 0 , vidainimigomax)
	barra.value = vida
	
	if vida <= 0:
		morrer()
		
func morrer():
	queue_free()
