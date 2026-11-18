
extends CharacterBody2D

@export var velocidade: float = 70.0
@export var aceleracao: float = 250.0
@export var atrito_gelo: float = 55.0
@export var vida: int = 3

var invencivel: bool = false

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $Hurtbox


func _process(_delta: float) -> void:
	if invencivel or vida <= 0:
		return

	for corpo in hurtbox.get_overlapping_bodies():
		if corpo.is_in_group("inimigo"):
			levar_dano()
			break



func _physics_process(delta: float) -> void:
	var direcao := Input.get_vector("left", "right", "up", "down")

	if direcao != Vector2.ZERO:
		velocity = velocity.move_toward(
			direcao * velocidade,
			aceleracao * delta
		)
	else:
		velocity = velocity.move_toward(
			Vector2.ZERO,
			atrito_gelo * delta
		)

	move_and_slide()

	if direcao == Vector2.ZERO:
		if velocity.length() < 5.0:
			anim.stop()
		return

	if abs(direcao.x) > abs(direcao.y):
		if direcao.x > 0:
			anim.play("right")
		else:
			anim.play("left")
	else:
		if direcao.y > 0:
			anim.play("down")
		else:
			anim.play("up")




func levar_dano() -> void:
	if invencivel or vida <= 0:
		return

	invencivel = true
	vida -= 1

	print("Vida restante: ", vida)

	if vida <= 0:
		morrer()
		return

	modulate.a = 0.4

	await get_tree().create_timer(1.0).timeout

	modulate.a = 1.0
	invencivel = false



func morrer() -> void:
	print("Você morreu!")
	get_tree().current_scene.perder()



	invencivel = false
