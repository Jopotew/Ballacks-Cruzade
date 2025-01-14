extends Control
class_name Card

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
@export var card_action_data : Resource 
@export var card_text_data : Resource


@onready var description_label: Label = $DescriptionLabel
@onready var cost_label: Label = $CostLabel
@onready var dmg_label: Label = $DmgLabel
@onready var card_name_label: Label = $CardNameLabel
@onready var card_sprite: TextureRect = $CardSprite
@onready var card_type : Label = $TypeLabel

signal card_dropped(card_data)

var card_damage : int
var card_healing : int
var card_effects : Array[EffectRes]
var card_element : String

var is_being_dragged : bool = false
var drag_offset := Vector2()
var previous_pos 

const CARD_SIZE := Vector2(150, 230)



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#


func _ready() -> void:
    GlobalData.card_size = CARD_SIZE
    set_card_action()
    set_card_model()
    visible = true
    
    
func set_res(_action : Resource, _text: Resource):
    card_action_data = _action
    card_text_data = _text
    print("Carta configurada con acción:", _action, "y texto:", _text)

    
func  set_card_model():
    cost_label.set_text(str(card_text_data.cost))
    card_name_label.set_text(card_text_data.name)
    description_label.set_text(card_text_data.description)
    card_sprite.set_texture(card_text_data.sprite)
    card_type.set_text(card_text_data.type)
    
    
func set_card_action():
    card_damage = card_action_data.damage 
    card_healing = card_action_data.healing
    card_effects = card_action_data.effects
    card_element = card_action_data.element
    
    
    

    
    #
#func _get_drag_data(at_position: Vector2) -> Variant:
    #var data : Dictionary 
    #data["action"] = card_action_data
    #return data
    #
#
#func _gui_input(event: InputEvent) -> void:
    #if event is InputEventMouseButton:
        #if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            #is_being_dragged = true
            #previous_pos = global_position  # Guardamos la posición antes de mover
            #drag_offset = global_position - event.global_position
        #elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
            #if is_being_dragged:
                #is_being_dragged = false
                #emit_signal("card_dropped", _get_drag_data(global_position))  # Emitimos la señal al soltar
            #global_position = previous_pos  # Volvemos a la posición original si no fue un "drop" válido
#
#
#func return_to_previous_position() -> void:
    #global_position = previous_pos
 #
    #
    #
    
    
#func _gui_input(event: InputEvent) -> void:
    #if event is InputEventMouseButton and event.button_index == 1:
        #if event.pressed:
            #is_being_dragged = true
            #drag_offset = global_position - event.global_position
        #else:
            #if is_being_dragged:
                #emit_signal("card_dropped", self)  
            #is_being_dragged = false
                #
#func _get_drag_data(position: Vector2) -> Variant:
    #return {"action": card_action_data, "text": card_text_data}
#
## Lógica para moverse mientras se arrastra (te permite mover el nodo)
#func _input(event: InputEvent) -> void:
    #if event is InputEventMouseMotion and is_being_dragged:
        ## Si estamos arrastrando, mueve el nodo con el ratón
        #self.position += event.relative
