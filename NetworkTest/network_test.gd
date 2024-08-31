extends Node2D

const PORT_NUMBER: int = 1336

@export var status_color: ColorRect

var peer: ENetMultiplayerPeer
var has_created_server: bool = false
var has_created_client: bool = false

func _ready():

	multiplayer.peer_connected.connect(_on_client_connected)
	multiplayer.peer_disconnected.connect(_on_client_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connection_fail)

func _on_client_connected(id):

	print("Client has connected: " + str(id))

func _on_client_disconnected(id):

	print("Client has disconnected: " + str(id))

func _on_connected_ok():

	print("Connected to server successfully.")

func _on_connection_fail():

	print("Failed connecting to server.")

func _on_create_server_pressed():

	if not has_created_server and not has_created_client:

		has_created_server = true

		peer = ENetMultiplayerPeer.new()
		peer.create_server(PORT_NUMBER, 8)
		multiplayer.multiplayer_peer = peer

		print("Server ID: " + str(multiplayer.get_unique_id()))
		print("Is Server: " + str(multiplayer.is_server()))

		create_tween().set_trans(Tween.TRANS_QUAD).tween_property($CanvasLayer/Control/PanelContainer, "position:y", 2000, 1)
		$CanvasLayer/Control/Chatbox.visible = true

func _on_join_server_pressed():
	
	if not has_created_client and not has_created_server:

		has_created_client = true

		var desired_address_target: String = $CanvasLayer/Control/PanelContainer/VBoxContainer/HBoxContainer/IPAddress.text

		peer = ENetMultiplayerPeer.new()
		peer.create_client(desired_address_target, PORT_NUMBER)
		multiplayer.multiplayer_peer = peer

		create_tween().set_trans(Tween.TRANS_QUAD).tween_property($CanvasLayer/Control/PanelContainer, "position:y", 2000, 1)
		$CanvasLayer/Control/Chatbox.visible = true

func _on_button_pressed():
	
	_random_rpc_func.rpc()

@rpc("any_peer","call_remote","unreliable",0)
func _random_rpc_func():

	print("hello my name is " + str(multiplayer.get_unique_id()))
	$CanvasLayer/Control/ColorRect.color = Color.LIGHT_SEA_GREEN

func _on_line_edit_text_submitted(new_text: String):
	
	_change_chatbox_label.rpc(new_text)

@rpc("any_peer","call_local","unreliable",0)
func _change_chatbox_label(new_text):

	$CanvasLayer/Control/Chatbox/Label.set_text(new_text)
