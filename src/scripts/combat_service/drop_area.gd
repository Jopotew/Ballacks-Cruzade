extends Area2D
class_name DropArea

signal card_dropped(card_data)

func _ready() -> void:
    set_process_input(true)  # Asegúrate de que el `DropArea` pueda recibir entrada de mouse

# Comprobamos si la carta puede ser soltada aquí (puedes agregar validación adicional si lo necesitas)
func _can_drop_data(position: Vector2, data: Dictionary) -> bool:
    return true  # Aquí puedes agregar más lógica para validar si la carta se puede soltar

# Función para recibir y manejar la carta soltada
func _drop_data(position: Vector2, data: Dictionary) -> void:
    print("Signal sent. Card Dropped with data:", data)
    emit_signal("card_dropped", data)  # Emitir la señal de "card_dropped"
