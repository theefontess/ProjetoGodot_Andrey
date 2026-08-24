extends Node3D


@onready var coin = preload("res://Prefab/coin.tscn")

var tamanho_mapa = Vector2(150.0, 150.0)

@onready var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void: # Simular o Start
	for i in range(10): # Cria 10 objetos
		var instancia = coin.instantiate() # Cria o Objeto
		
		var x = rng.randf_range(-tamanho_mapa.x, tamanho_mapa.x)
		var z = rng.randf_range(-tamanho_mapa.y, tamanho_mapa.y)
		
		instancia.position = Vector3(x, 0, z)
		add_child(instancia) # Adiciona na Cena atual


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): # Simular o Update
	pass
		
