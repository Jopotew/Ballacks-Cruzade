extends Node
class_name CombatManager

signal turn_ended
signal turn_started




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


func _on_card_dropped(card_data: Dictionary) -> void:
    var action = card_data["action"]
    var text = card_data["text"]
    print("Card dropped: ", action.name, text.name)
    # Aquí puedes añadir la lógica para usar la carta, como iniciar un ataque, etc.
