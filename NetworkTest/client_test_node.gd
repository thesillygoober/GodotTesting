extends Node2D

var peer

func _on_join_server_pressed():
	
	var desired_ip: String = get_parent().get_node("CanvasLayer/Control/PanelContainer/VBoxContainer/HBoxContainer/IPAddress").text

	peer = ENetMultiplayerPeer.new()
	peer.create_client(desired_ip, 1336)
	multiplayer.multiplayer_peer = peer

func _process(_delta):

	if peer: print(peer.get_connection_status())
