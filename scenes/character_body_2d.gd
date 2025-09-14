extends CharacterBody2D
# Importa o node de sprite do player
@onready var animated_sprite_2d = $player_sprite

@export var jump_count: int = 2 

const GRAVITY = 1000
const SPEED = 140
const JUMP = -300
const JUMP_HORIZONTAL = 70

enum State { Idle, Run, Jump }

var current_state
var current_jump_count: int
var vida = 3

func _ready():
	current_state = State.Idle
	add_to_group("player")
	
func _physics_process(delta):
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	player_animations()
	move_and_slide()

func player_falling(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta

func player_idle(delta):
	pass
	if is_on_floor():
		current_state = State.Idle
		print("State:", State.keys()[current_state])

func player_run(delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction != 0:
		current_state = State.Run
		print("State:", State.keys()[current_state])
		animated_sprite_2d.flip_h = false if direction > 0 else true

func player_jump(delta):
	
	var jump_input: bool = Input.is_action_just_pressed("jump")
	
	if is_on_floor() and jump_input:
		current_jump_count = 0
		velocity.y = JUMP
		current_jump_count += 1
		current_state = State.Jump
		
	if !is_on_floor() and jump_input and current_jump_count < jump_count:
		current_jump_count = 1
		velocity.y = JUMP
		current_jump_count += 1
		current_state = State.Jump
		
	if !is_on_floor() and current_state == State.Jump:
		var direction = Input.get_axis("move_left", "move_right")
		velocity.x += direction * JUMP_HORIZONTAL * delta
		
func player_animations():
	if current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Run:
		animated_sprite_2d.play("run")
	elif current_state == State.Jump:
		animated_sprite_2d.play("jump")
