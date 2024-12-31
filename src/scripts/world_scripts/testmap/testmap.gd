extends Node2D

##Select the COMBAT SCENE that is requiered. 
@export var combat_scene : PackedScene


func _on_area_2d_body_entered(body: Node2D) -> void:
    print("Enter")
    GlobalData.player_card_deck = $Cleric.card_deck
    GlobalData.player_stats = $Cleric.stats
    GlobalData.player_texture = $Cleric/PlayerSprite.texture
    get_tree().change_scene_to_packed(combat_scene)
