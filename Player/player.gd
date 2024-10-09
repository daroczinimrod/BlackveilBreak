extends CharacterBody2D

@onready var PlayerAnim = $AnimatedSprite2D
const SPEED = 225.0
const JUMP_VELOCITY = -500.0
var current_direction = Vector2.RIGHT
var time = 0
@onready var timer: Timer = $Timer
@onready var timer_2: Timer = $Timer2
@onready var halal: AnimationPlayer = $Death


func update_ui():
	var formatted_time = str(time)
	var minutes = fmod(time, 60*60) / 60
	var seconds = fmod(time, 60)
	var msecs = fmod(time, 1) *1000
	Global.time = seconds
	if minutes == 0:
		formatted_time = "%02d . %03d" % [seconds,msecs]
	elif minutes > 0:
		formatted_time = "%02d : %02d . %03d" % [minutes,seconds,msecs]
	$Camera2D/CanvasLayer/Panel/Minutes.text = formatted_time
	Global.score = str(formatted_time)
	
func _physics_process(delta: float) -> void:

	if Global.Dead == false:
		time = float(time) + delta
		update_ui()
		
		if is_on_floor() and velocity.x == 0:
			PlayerAnim.play("Idle")
		
		const GRAVITY = 1000.0
		if not is_on_floor():
			velocity.y += GRAVITY * delta
		
		var direction := Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		
		if Input.is_action_just_pressed("Right") and is_on_floor():
			current_direction = Vector2.RIGHT
		elif Input.is_action_just_pressed("Left") and is_on_floor():
			current_direction = Vector2.LEFT
				
		if current_direction == Vector2.RIGHT and is_on_floor() and direction:
			PlayerAnim.flip_h = false
			PlayerAnim.play("Run")
		elif current_direction == Vector2.LEFT and is_on_floor() and direction:
			PlayerAnim.flip_h = true
			PlayerAnim.play("Run")
				
			
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			PlayerAnim.play("Jump")
				
		if not is_on_floor() and Input.is_action_just_pressed("Left") and current_direction == Vector2.RIGHT:
			PlayerAnim.flip_h = true
		elif not is_on_floor() and Input.is_action_just_pressed("Right") and current_direction == Vector2.LEFT:
			PlayerAnim.flip_h = false
			
		move_and_slide()
	else:
		pass


func death():
	$AnimatedSprite2D.play("Death")
	Global.Dead = true
