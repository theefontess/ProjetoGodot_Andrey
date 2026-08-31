extends Area3D

@export var velocidade: float = 25.0
@export var dano: int = 10
var tempovida: float = 3.0
var direcao: Vector3 = Vector3.ZERO

func _ready():
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	global_position += direcao * velocidade * delta
	tempovida -= delta
	if tempovida <= 0.0:
		queue_free()
func _on_body_entered(body):
	if body.is_in_group("player"):
		return
	if body.has_method("receber_dano"):
		body.receber_dano(dano)
	queue_free()
