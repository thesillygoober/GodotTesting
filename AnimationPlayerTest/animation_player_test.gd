extends Node2D

func _input(event):

	if event.is_action_pressed("ui_accept"):

		$Sprite2D/AnimationPlayer.play("spin")
		$Label/AnimationPlayer.play("rainbowtext")