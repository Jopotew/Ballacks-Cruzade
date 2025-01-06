extends Area2D
class_name DropArea


signal card_dropped(card_data)

func _ready() -> void:
    set_process_input(true)  # Habilitar la entrada de ratón para detectar el drop


func _can_drop_data(position: Vector2, data: Variant) -> bool:
    return true  
    
func _drop_data(position: Vector2, data: Variant) -> void:
    emit_signal("card_dropped", data)  
