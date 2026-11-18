
extends CharacterBody2D

@export var velocidade: float = 40.0

func _physics_process(_delta: float) -> void:
	var jogador = get_tree().get_first_node_in_group("player")

	if jogador == null:
		return

	var direcao = global_position.direction_to(jogador.global_position)

	velocity = direcao * velocidade
	move_and_slide()
