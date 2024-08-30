extends CharacterBody2D

var SPEED = 100.0
const JUMP_VELOCITY = -800.0

func _physics_process(delta):

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_h_slider_drag_ended(value_changed:bool):
	
	if value_changed: SPEED = get_parent().get_node("CanvasLayer/Control/HSlider").value
