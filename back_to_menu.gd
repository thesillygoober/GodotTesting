extends Button

func _ready():

    self.pressed.connect(go_back)

func go_back():

    get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")