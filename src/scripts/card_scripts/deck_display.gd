## DeckDisplay.gd
class_name HandDisplay
extends ColorRect

@export var hand_curve: Curve
@export var rotation_curve: Curve
@export var max_rotation_degrees := 10
@export var x_sep := 50
@export var y_min := 50
@export var y_max := -50
@export var card_inventory : Array[PackedScene] = []  # El inventario de cartas del jugador

var live_hand : Array[PackedScene] = []
var card_size = GlobalData.card_size
const max_hand_size = 5
var hand_size = 0


## Conectar la señal de inicio del combate
func _ready() -> void:
    # Conectar la señal emitida por CombatService para empezar el combate
    CombatService.connect("combat_started",_on_combat_started)
    

func _on_combat_started():
    print("COMBAT STARTED")

func draw() -> void:
    var index = randi_range(0, card_inventory.size())
    if hand_size < max_hand_size:
        var cards = card_inventory[index]
        var card_node = cards.instantiate()  # Nodo instanciado
        live_hand.append({
            "scene": cards,  
            "node": card_node 
        })
        add_child(card_node)
        hand_size += 1

        print("Live Hand : ", live_hand)
        print("Node Added : ", card_node.name)

    update_cards()



func discard(card_to_remove : Node2D) -> void:
    if not card_to_remove or not is_instance_valid(card_to_remove):
        return
        
    for i in range(live_hand.size()):
        if live_hand[i].name == card_to_remove.name:
            live_hand.remove_at(i)
            break
            
    card_to_remove.queue_free()
    hand_size -= 1
    update_cards()


func update_cards() -> void:
    var cards := get_child_count()
    var all_cards_size := Card.SIZE.x * cards + x_sep * (cards - 1)
    var final_x_sep = x_sep
    
    if all_cards_size > size.x:
        final_x_sep = (size.x - Card.SIZE.x * cards) / (cards - 1)
        all_cards_size = size.x

    var offset := (size.x - all_cards_size) / 2
    
    for i in cards:
        var card := get_child(i)
        var y_multiplier := hand_curve.sample(1.0 / (cards-1) * i)
        var rot_multiplier := rotation_curve.sample(1.0 / (cards-1) * i)
        
        if cards == 1:
            y_multiplier = 0.0
            rot_multiplier = 0.0
        
        var final_x: float = offset + Card.SIZE.x * i + final_x_sep * i
        var final_y: float = y_min + y_max * y_multiplier
        
        card.position = Vector2(final_x, final_y)
        card.rotation_degrees = max_rotation_degrees * rot_multiplier


func initialize_inventory(inventory: Array[PackedScene]) -> void:
    card_inventory = inventory
    set_hand()
    update_cards()
    
    

func set_hand():
    while hand_size < max_hand_size:
        var index = randi_range(0,card_inventory.size()-1)
        var cards = card_inventory[index]
        var card = cards.instantiate()
        live_hand.append(cards)
        add_child(card)
        hand_size += 1
        print("Live Hand : ",live_hand)
    update_cards()
    


func add_card_to_hand(new_card: PackedScene) -> void:
    if hand_size < max_hand_size:
        live_hand.append(new_card)  
        hand_size += 1
        
        var card_instance = new_card.instantiate()
        add_child(card_instance)
        update_cards()


func _on_combat_manager_turn_ended() -> void:
    if hand_size < max_hand_size and card_inventory.size() > 0:
        var next_card = card_inventory[hand_size % card_inventory.size()]
        add_card_to_hand(next_card)
