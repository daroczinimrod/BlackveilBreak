extends Area2D


func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.death()
