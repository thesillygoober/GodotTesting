extends Node2D

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
        peer.create_server(1336, 8)
        multiplayer.multiplayer_peer = peer

        print("Server ID: " + str(multiplayer.get_unique_id()))
        print("Is Server: " + str(multiplayer.is_server()))

func _on_join_server_pressed():
	
    if not has_created_client and not has_created_server:

        has_created_client = true

        var desired_address_target: String = $CanvasLayer/Control/PanelContainer/VBoxContainer/HBoxContainer/IPAddress.text

        peer = ENetMultiplayerPeer.new()
        peer.create_client(desired_address_target, 1336)
        multiplayer.multiplayer_peer = peer