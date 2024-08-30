extends Node2D

@export var anim1: Sprite2D
@export var anim2: Sprite2D
@export var points: Node

func _on_tick_rate_timeout():
	
	var anim1_tick: int = RandomNumberGenerator.new().randi_range(0, 50)
	var anim2_tick: int = RandomNumberGenerator.new().randi_range(0, 50)
	var anim1_target: Node2D
	var anim2_target: Node2D

	match anim1_tick:

		5:
			
			anim1_target = points.get_children()[RandomNumberGenerator.new().randi_range(0, len(points.get_children()))-1]
			if anim1_target.position == anim2.position: anim1_target = null
		
		_:

			print("anim 1 don't move")

	match anim2_tick:

		5:
			
			anim2_target = points.get_children()[RandomNumberGenerator.new().randi_range(0, len(points.get_children()))-1]
			if anim2_target.position == anim1.position: anim2_target = null

		_:

			print("anim 2 don't move")

	if anim1_target == anim2_target:

		anim2_target = null
	
	if anim1_target: anim1.position = anim1_target.position
	if anim2_target: anim2.position = anim2_target.position

	print(anim1.position)
	print(anim2.position)