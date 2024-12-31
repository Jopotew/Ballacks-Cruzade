extends Resource
class_name CharacterStats

## Salud máxima del personaje.
@export var health: int

## Daño físico que el personaje puede causar.
@export var physical_dmg: int

## Daño mágico que el personaje puede causar.
@export var magic_dmg: int

## Destreza del personaje, que puede influir en la evasión o velocidad de ataque.
@export var dexterity: int

## Inteligencia del personaje, que puede influir en habilidades mágicas o de sabiduría.
@export var intelligence: int

## Lugar donde se agregan items al personaje,
@export var item_bag : Array

## Estado del personaje: si está vivo o muerto.
var alive: bool

## Salud máxima calculada al inicio, igual a la salud inicial.
var max_health = health
