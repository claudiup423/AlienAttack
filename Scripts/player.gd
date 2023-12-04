extends CharacterBody2D

signal took_damage

var speed = 300
var rocket_scene = preload("res://Scenes/rocket.tscn")

var next_shot_time = 0
@export var time_between_shots : float = 1

@onready var rocket_container = get_node("RocketContainer")
@onready var fire_sound_effect = $FireSound

func _physics_process(delta):
	velocity = Vector2(0,0)
	if Input.is_action_pressed("right"):
		velocity.x = speed
	if Input.is_action_pressed("left"):
		velocity.x = -speed
	if Input.is_action_pressed("up"):
		velocity.y = -speed
	if Input.is_action_pressed("down"):
		velocity.y = speed
	move_and_slide()
	clamp_player()

		
func clamp_player():
	var windowSize = get_viewport_rect().size		
	global_position = global_position.clamp(Vector2(0,0), windowSize)

func _process(delta):
	if Input.is_action_pressed("shoot"):
		if next_shot_time <= Time.get_ticks_msec():
			# since the measure of time is in milliseconds, just multipled the value in seconds to get miliseconds
			next_shot_time = Time.get_ticks_msec() + (time_between_shots*1000)
			shoot()	
	
func shoot():
	fire_sound_effect.play()
	var rocket_instance = rocket_scene.instantiate()
	rocket_container.add_child(rocket_instance)
	rocket_instance.global_position = global_position
	rocket_instance.global_position.x += 80

func take_damage():
	emit_signal("took_damage")
	
func die():
	queue_free()
	
