extends Node3D


@onready var arvore = preload("res://Prefab/Tree.tscn")

var tamanho_mapa = Vector2(100.0, 100.0)

@onready var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void: # Simular o Start
	for i in range(30): # Cria 10 objetos
		var instancia = arvore.instantiate() # Cria o Objeto
		
		var x = rng.randf_range(-tamanho_mapa.x, tamanho_mapa.x)
		var z = rng.randf_range(-tamanho_mapa.y, tamanho_mapa.y)
		
		instancia.position = Vector3(x, 0, z)
		add_child(instancia) # Adiciona na Cena atual


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): # Simular o Update
	pass
		
