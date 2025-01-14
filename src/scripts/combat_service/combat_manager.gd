extends Node
class_name CombatManager

signal turn_ended
signal turn_started




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.




func _on_drop_area_card_dropped(card_data: Variant) -> void:
    print("Card dropped in combat scene with data:", card_data)
