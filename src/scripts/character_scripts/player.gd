extends Node2D
class_name Player

@export var stats : CharacterStats

@onready var player_sprite: Sprite2D = $PlayerSprite

var card_deck : Array[String] = ["Heal", "Guard", "Stab", "Poison"]

## Velocidad de movimiento
@export var move_speed : float = 200.0


func _ready() -> void:
    pass
    
## Método que se llama cada frame para mover al jugador
func _process(delta: float) -> void:
    # Movimiento con las teclas de dirección
    var direction = Vector2.ZERO
    
    # Detecta si se presionan las teclas de dirección
    if Input.is_action_pressed("ui_right"):  # Tecla de flecha derecha o D
        direction.x += 1
    if Input.is_action_pressed("ui_left"):   # Tecla de flecha izquierda o A
        direction.x -= 1
    if Input.is_action_pressed("ui_down"):   # Tecla de flecha abajo o S
        direction.y += 1
    if Input.is_action_pressed("ui_up"):     # Tecla de flecha arriba o W
        direction.y -= 1

    # Si la dirección tiene algún valor, mover al jugador
    if direction != Vector2.ZERO:
        direction = direction.normalized()  # Asegura que el movimiento no sea más rápido en diagonal
        
        # Actualiza la posición del jugador directamente
        position += direction * move_speed * delta

    
