
extends Node2D

@export var cena_inimigo: PackedScene

func _on_horda_timeout() -> void:
	if cena_inimigo == null:
		return

	var novo = cena_inimigo.instantiate()
	add_child(novo)

	var ponto = $Nascedouros.get_children().pick_random()

	novo.get_node("inimigo").global_position = ponto.global_position

func _process(_delta: float) -> void:
	$HUD/Aliados.text = "Aliados: %d/5" % fila.size()
	var jogador = get_tree().get_first_node_in_group("player")

	if jogador != null:
		$HUD/Vida.text = "Vida: %d" % jogador.vida



func perder() -> void:
	$HUD/Mensagem.text = "VOCÊ PERDEU!"
	$HUD/JogarNovamente.visible = true
	get_tree().paused = true

func _on_jogar_novamente_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

var fila: Array[Node2D] = []

func resgatou(aliado: Node2D) -> void:
	var jogador = get_tree().get_first_node_in_group("player")

	if jogador == null:
		return

	if fila.is_empty():
		aliado.lider = jogador
	else:
		aliado.lider = fila.back()

	fila.append(aliado)

	print("Aliados resgatados: ", fila.size(), "/5")

	if fila.size() >= 5:
		vencer()

func vencer() -> void:
	$HUD/Mensagem.text = "VOCÊ VENCEU!"
	$HUD/JogarNovamente.visible = true
	get_tree().paused = true
