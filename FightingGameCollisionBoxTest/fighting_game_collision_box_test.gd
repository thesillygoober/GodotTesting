extends Node2D

@export var square1: CharacterBody2D
@export var square2: CharacterBody2D
var pushback: bool = false

func _ready():

	square1.get_node("Area2D").connect("area_entered", start_push_back)
	square1.get_node("Area2D").connect("area_exited", end_push_back)

func start_push_back(area):

	if (area.get_parent().name == square2.name and not square1.is_on_floor()) or (area.get_parent().name == square1.name and not square2.is_on_floor()):

		var square1_collision_size_x: float = square1.get_node("Area2D/CollisionShape2D").shape.size.x
		#var square2_collision_size_x: float = square2.get_node("Area2D/CollisionShape2D").shape.size.x
		var distance: float = abs(square1.position.x - square2.position.x)
		var collision_gap_x: float = abs(square1_collision_size_x - distance) / 2
		square1.position.x -= collision_gap_x
		square2.position.x += collision_gap_x

		pushback = true

	elif area.name == "Area2D" and area.get_parent().name == square2.name:

		print("initiate pushback")
		pushback = true

func end_push_back(area):

	if area.name == "Area2D" and area.get_parent().name == square2.name:

		print("exit pushback")
		pushback = false	

func _physics_process(_delta):

	if pushback:

		var square1_collision_size_x: float = square1.get_node("Area2D/CollisionShape2D").shape.size.x
		#var square2_collision_size_x: float = square2.get_node("Area2D/CollisionShape2D").shape.size.x
		var distance: float = abs(square1.position.x - square2.position.x)
		var collision_gap_x: float = abs(square1_collision_size_x - distance)
		square1.position.x -= collision_gap_x
		square2.position.x += collision_gap_x
