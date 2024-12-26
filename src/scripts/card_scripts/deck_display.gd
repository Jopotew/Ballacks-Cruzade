extends Node2D

@onready var card_scene : PackedScene = preload("res://src/scenes/card_scenes/card.tscn")
@onready var spawn_point : Node2D = $CanvasLayer/SpawnPoint


 #Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _on_button_2_pressed() -> void:
    var card : Card = card_scene.instantiate() 
    spawn_point.add_child(card)
    card.set_card_values(3, "CARD NAME", "CARD DESCRIPTION")
    card.visible = true
    
    

func _on_button_pressed() -> void:
    pass # Replace with function body.
