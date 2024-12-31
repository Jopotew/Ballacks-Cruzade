## DeckDisplay.gd

extends Control

@onready var spawn_point : Node2D = $CanvasLayer/SpawnPoint
@export var card_inventory : Array[PackedScene] = []  # El inventario de cartas del jugador

var live_hand : Array[PackedScene] = []
var separation = 20
var card_size = GlobalData.card_size
const max_hand_size = 5
var hand_size = 0

## Conectar la señal de inicio del combate
func _ready() -> void:
    # Conectar la señal emitida por CombatService para empezar el combate
    CombatService.connect("combat_started",_on_combat_started)
    


## Método para inicializar el inventario
func initialize_inventory(inventory: Array[PackedScene]) -> void:
    card_inventory = inventory
    set_hand()
    organize_cards()
    
    

## Método para mostrar las cartas en la escena
func set_cards_visible() -> void:
    for cards in live_hand:
        var card = cards.instantiate()
        add_child(card)
        card.visible = true
        
        
func discard(card_used) -> void:
    for card in live_hand:
        if card.card_name == card_used.card_name:
            live_hand.erase(card)
            card.queue_free()
            break  
    organize_cards()

            

func set_hand():
    var card_index = 0
    while hand_size < max_hand_size:
        var card = card_inventory[card_index]
        live_hand.append(card)
        hand_size += 1
        card_index = (card_index + 1) % card_inventory.size()  

        
func update_cards() -> void:
    for child in get_children():
        if child is Control:  # Verifica si el nodo es un control para evitar errores
            child.queue_free()
    
    # Reorganizar las cartas en la mano
    organize_cards()



func _on_combat_started() -> void:
    print("¡El combate ha comenzado!")
   
func organize_cards() -> void:
    var rect_width = 800
    var rect_height = 230
    var card_width = card_size.x  
    var card_height = card_size.y  
    var max_cards_in_rect = min(live_hand.size(), 5)  

    var total_separation = (max_cards_in_rect - 1) * separation
    var total_card_width = max_cards_in_rect * card_width + total_separation
    
    var start_x = (rect_width - total_card_width) / 2

    var i = 0
    for card_node in get_children():
        if card_node is Control and i < live_hand.size():
            var pos_x = start_x + i * (card_width + separation)
            var pos_y = (rect_height - card_height) / 2 
            card_node.position = Vector2(pos_x, pos_y)
            card_node.visible = true
            i += 1

 
func add_card_to_hand(new_card: PackedScene) -> void:
    if hand_size < max_hand_size:
        live_hand.append(new_card)  
        hand_size += 1
        
        var card_instance = new_card.instantiate()
        add_child(card_instance)
    
        organize_cards()


func _on_combat_manager_turn_ended() -> void:
    if hand_size < max_hand_size and card_inventory.size() > 0:
        var next_card = card_inventory[hand_size % card_inventory.size()]
        add_card_to_hand(next_card)
