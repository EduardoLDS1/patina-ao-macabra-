
extends Area2D

var lider: Node2D = null

func _physics_process(delta: float) -> void:
	if lider != null:
		if global_position.distance_to(lider.global_position) > 14:
			global_position = global_position.move_toward(
				lider.global_position,
				70 * delta
			)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and lider == null:
		get_tree().current_scene.resgatou(self)

	elif body.is_in_group("inimigo") and lider != null:
		get_tree().current_scene.perder()
