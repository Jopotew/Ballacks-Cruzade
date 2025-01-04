extends Resource
class_name CardText


## Tipo de carta: "daño", "defensivo", "buff", "debuff", etc.
@export var type: String

## Nombre de la carta. Ejemplo: "Stab", "Heal", etc.
@export var name: String

## Descripción detallada de lo que hace la carta.
@export var description: String

## Sprite de la carta
@export var sprite : Texture

## Costo de la carta en puntos de energía.
@export var cost: int
