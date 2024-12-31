extends Node

signal combat_started  # Señal que indica que el combate ha comenzado

## Método para iniciar el combate
func start_combat() -> void:
    # Emitir la señal para notificar el inicio del combate
    emit_signal("combat_started")
