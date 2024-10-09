extends Node2D

var checkpoint_manager
var player
var time = 0
var formatted_sec: int = 0
var seconds = fmod(time, 60)
var elkezdodott = false

func _ready():
	
	process_mode = Node.PROCESS_MODE_PAUSABLE
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$AnimationPlayer.play("Fade in")

func _process(delta: float) -> void:
	

	if Global.paused == false and Input.is_action_just_pressed("Pause"):
		get_tree().paused = true
		Global.paused = true
		$AnimationPlayer.play("Pause")
	elif Global.paused == true and Input.is_action_just_pressed("Pause"):
		get_tree().paused = false
		Global.paused = false
		$AnimationPlayer.play("Unpause")	
		
	
	if Global.Dead == true:
		time = float(time) + delta
		var seconds = int(fmod(time, 60))
		if seconds == 1:
			$AnimationPlayer.play("Deathscreen")
		elif seconds == 5:
			get_tree().reload_current_scene()
			Global.Dead = false
			


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Fade in" and elkezdodott == false:
		$AnimationPlayer.play("Controls Tip")
		elkezdodott = true
	else:
		pass


func _on_scoreboard_body_entered(body: Node2D) -> void:
	$Panel.show()

func _on_scoreboard_body_exited(body: Node2D) -> void:
	$Panel.hide()
