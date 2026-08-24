extends Control

@onready var label_pontuacao = $LabelPontuacao
@onready var label_tempo = $LabelTempo

var pontuacao:= 0
var tempo:= 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tempo += delta
	label_tempo.text = "Tempo: " + formatar_tempo(tempo)
	
func adicionar_pontos(pontos: int):
	pontuacao +=pontos 
	label_pontuacao.text = "Pontos: " + str(pontuacao)
	
func formatar_tempo(segundos: float) -> String:
	var minuto := int(segundos) / 60
	var segundos_restantes := int(segundos) % 60
	
	return "%02d:%02d" % [minuto, segundos_restantes]
