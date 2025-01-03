#combat_scene.gd
extends Node

var p_stats 
var p_card_deck
var p_sprite


@onready var player_place: TextureRect = $PlayerPlace

func _ready() -> void:
    load_player()
    start_combat()
        
        
    
func load_player():
    p_stats = GlobalData.player_stats
    p_card_deck = GlobalData.player_card_deck
    p_sprite = GlobalData.player_texture
    player_place.set_texture(p_sprite)

## Método para iniciar el combate
func start_combat() -> void:
    # Aquí se inicia la lógica del combate
    print("Iniciando combate...")
    CombatService.emit_signal("combat_started")
    prepare_cards_for_combat()

## Preparar las cartas para el combate
func prepare_cards_for_combat() -> void:
    # Aquí es donde puedes poner la lógica para usar el inventario del jugador
    var deck_display = $HandDisplay/Hand
    deck_display.initialize_inventory(p_card_deck) 
