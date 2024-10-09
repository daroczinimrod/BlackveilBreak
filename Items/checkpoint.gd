extends Area2D

var checkpoint_manager

func _ready():
	pass



func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		#checkpoint_manager.last_location = $Respawnpoint.global_position
		if Global.spawnpoint == false:
			$AnimatedSprite2D.play("Activate")
			Global.spawnpoint = true



func _on_animated_sprite_2d_animation_finished():
			$AnimatedSprite2D.play("Activated")
	
