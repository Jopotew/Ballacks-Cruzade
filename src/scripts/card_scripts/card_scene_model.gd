extends Control
class_name CardModel

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
@export var card_action_data : Resource 
@export var card_text_data : Resource


@onready var description_label: Label = $DescriptionLabel
@onready var cost_label: Label = $CostLabel
@onready var dmg_label: Label = $DmgLabel
@onready var card_name_label: Label = $CardNameLabel
@onready var card_sprite: TextureRect = $CardSprite
@onready var card_type : Label


var card_damage : int
var card_healing : int
var card_effects : Array[EffectRes]
var card_element : String



const CARD_SIZE := Vector2(150, 230)



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#


func _ready() -> void:
    GlobalData.card_size = CARD_SIZE
    set_card_action()
    set_card_model()
    visible = true
    
func  set_card_model():
    cost_label.set_text(card_text_data.cost)
    card_name_label.set_text(card_text_data.name)
    description_label.set_text(card_text_data.description)
    card_sprite.set_texture(card_text_data.sprite)
    card_type.set_text(card_text_data.type)
    
    
func set_card_action():
    card_damage = card_action_data.damage 
    card_healing = card_action_data.healing
    card_effects = card_action_data.effects
    card_element = card_action_data.element
    
func _get_drag_data(position):
    var loan
    return loan
    
    
