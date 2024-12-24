extends Control


@export var world : Node2D
@export var player_scene : PackedScene
@onready var marker_2d: Marker2D = $"../World/Marker2D"

func spawn_player(character_type : String) -> void :
    var stats := load("res://src/resources/%s.tres" % character_type) as CharacterStats
    var player := player_scene.instantiate() as Player
    player.load_stats(stats)
    world.add_child(player)
    var player_spawn_pos = marker_2d.get_position()
    player.set_position(player_spawn_pos)
    queue_free()
   

func _process(delta):
    if Input.is_action_just_pressed("ui_accept"):
        spawn_player("mage")
