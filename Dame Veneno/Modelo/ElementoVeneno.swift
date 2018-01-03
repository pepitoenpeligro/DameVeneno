//
//  Interest.swift
//  Dame Veneno
//
//  Created by Jose Antonio Córdoba Gómez on 30/12/17.
//  Copyright © 2017 Jose Antonio Córdoba Gómez. All rights reserved.
//

import UIKit
import ChameleonFramework

class Utilidades{
    static let colores : [UIColor] = [
        UIColor.flatBlue,   // 0
        UIColor.flatBlueDark,   // 1
        UIColor.flatBrown,  // 2
        UIColor.flatBrownDark,  // 3
        UIColor.flatCoffee, // 4
        UIColor.flatCoffeeDark, // 5
        UIColor.flatForestGreen,    // 6
        UIColor.flatForestGreenDark,    // 7
        UIColor.flatGray,   // 8
        UIColor.flatGreen,  // 9
        UIColor.flatGreenDark,  // 10
        UIColor.flatLime,   // 11
        UIColor.flatLimeDark,   // 12
        UIColor.flatMagenta,    // 13
        UIColor.flatMaroon,     // 14
        UIColor.flatMint,   // 15
        UIColor.flatMintDark,   // 16
        UIColor.flatNavyBlue,   // 17
        UIColor.flatOrange, // 18
        UIColor.flatOrangeDark, // 19
        UIColor.flatPlum,   // 20
        UIColor.flatPlumDark,   // 21
        UIColor.flatPowderBlue, // 22
        UIColor.flatPowderBlueDark, //23
        UIColor.flatPurple, // 24
        UIColor.flatPurpleDark, //25
        UIColor.flatRed,    // 26
        UIColor.flatRedDark,    // 27
        UIColor.flatSkyBlue,    // 28
        UIColor.flatSkyBlueDark,    // 29
        UIColor.flatYellow  // 30
    ]
    
}

class ElementoVeneno
{
    
    var archivo: String!
    var titulo: String!
    var categoria: String!
    var color: UIColor
    var texto : String!
    
    // Constructor
    init(arch: String, tit: String, cat: String, text: String, col: UIColor)
    {
        self.archivo = arch
        self.titulo = tit
        self.categoria = cat
        self.texto = text
        self.color = col
        
    
        Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]

    }
    
    
    

    
    
    static func crearElementos() -> [ElementoVeneno]{
        return [
            ElementoVeneno(arch: "ATS",tit: "ATS",cat: "",text: "",col: Utilidades.colores[25]),
            ElementoVeneno(arch: "aDieta",tit: "A Dieta",cat: "",text: "",col: Utilidades.colores[28]),
            ElementoVeneno(arch: "aceite",tit: "Aceita",cat: "",text: "",col: Utilidades.colores[15]),
            ElementoVeneno(arch: "aceituna",tit: "Aceituna",cat: "",text: "",col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "adelante",tit: "Adelante",cat: "",text: "",col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "alamierda",tit: "A la mierda",cat: "",text: "",col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "ambipur",tit: "Ambipur",cat: "",text: "",col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "amiga",tit: "Amiga",cat: "",text: "",col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "amigoConDerechoARoce",tit: "Amigo",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "amino",tit: "A mi no",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "andaguapa",tit: "Anda Guapa",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "androcur",tit: "Androcur",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "aprende",tit: "Aprende",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "aprieta",tit: "Aprieta",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "ashin",tit: "Así mismo",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "arcancia",tit: "Arcancia",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "bellezas",tit: "Bellezas",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "besos",tit: "Besos",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "boxer",tit: "Boxer",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "brevas",tit: "Brevas",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "braguitas",tit: "Braguitas",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "brilla",tit: "Brilla",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "caballo",tit: "Caballo",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "calentona",tit: "Calentona",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "callaros",tit: "Callaros",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "callate",tit: "Callate",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "camaleonica",tit: "Camaleonica",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "camellona",tit: "Camellona",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "canalla",tit: "Canalla",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "cansa",tit: "Cansa",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "cantar",tit: "Cantar",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "canto",tit: "Canto",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "carne",tit: "Carne",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "cartier",tit: "Cartier",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "caso",tit: "Caso",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "chuparmamaryfollar",tit: "Chupar",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "colectivo",tit: "Colectivo",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "conio",tit: "Conio",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "conosia",tit: "Conozco",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "copia",tit: "Copia",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "cristina",tit: "Cristina",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "criticar",tit: "Criticar",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "cubata",tit: "Cubata",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "cuernos",tit: "Cuernos",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "cuerpo",tit: "Cuerpo",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "cuerpoCompleto",tit: "Cuerpo(2)",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "curriculum",tit: "Curriculum",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "dedos",tit: "Dedos",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "denegao",tit: "Denegao",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "deto",tit: "De todo",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "digo",tit: "Digo",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "diplomatico",tit: "Diplomático",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "dormir",tit: "Dormir",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "dosEnBragas", tit: "En Bragas",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "dotado",tit: "Dotado",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "ejercer",tit: "Ejercer",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "elegias",tit: "Elegías",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "enRumano",tit: "En Rumano",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "envidiaSana",tit: "Envidia Sana",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "envidiosa",tit: "Envidiosa",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "escoger",tit: "Escoger",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "espania",tit: "España",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "esta",tit: "Esta",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "fama", tit: "Fama",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "farmaceuticos", tit: "Farmaceúticos",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "farruquito", tit: "Farruquito",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "fea", tit: "Fea",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "fisna", tit: "Fisna",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "furgolista", tit: "Furgolista",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "geronimo", tit: "Gerónimo",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "gracias", tit: "Gracias",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "hastaLuego", tit: "Hasta Luego",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "higuera", tit: "Higuera",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "incurta", tit: "Inculta",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "insultar", tit: "Insultar",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "labio", tit: "Labio",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "labrar", tit: "Labrar",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "lavidaibaenserio", tit: "La vida iba en serio",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "lepego", tit: "Le pego",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "limusina", tit: "Limusina",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "loca", tit: "Loca",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "mal", tit: "Mal",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "mala", tit: "Mala",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "manola", tit: "Manola",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "manolo", tit: "Manolo",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "maradona", tit: "Maradona",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "maria", tit: "María",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "maritrini", tit: "Mari Trini",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "marranona", tit: "Marranona",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "matorral", tit: "Matorral",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "mequierestocar", tit: "Tocar",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "mercado", tit: "Mercado",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "meton", tit: "Mentón",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "mopa", tit: "Mopa",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "morcilla", tit: "Morcilla",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "muchisimasgracias", tit: "Gracias",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "muerta", tit: "Muerta",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "mundo", tit: "Mundo",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "muyrapido", tit: "Muy Rápido",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "negra", tit: "negra",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "nifaltaquetehace", tit: "Falta",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "nitengoGanas", tit: "Ganas",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "noQueValoh", tit: "Valor",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "noche", tit: "Noche",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "nollevobravas", tit: "Bragas",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "obesa", tit: "Obesa",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "obregon", tit: "Obregón",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "ojete", tit: "Ojete",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "ordinaria", tit: "Ordinaria",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "paipai", tit: "Paipai",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "paqueton", tit: "Paquetón",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "perdon", tit: "Perdón",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "personaje", tit: "Personaje",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "poderio", tit: "Poderío",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "polaca", tit: "Polaca",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "pollaNova", tit: "Polla Nova",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "pollaleopardo", tit: "Leopardo",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "pollicaNueva", tit: "Polla Nueva",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "popeye", tit: "Popeye",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "pues", tit: "Pues",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "puton", tit: "Putón",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "quiere", tit: "Quiere",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "quirofano", tit: "Quirófano",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "quirofanoCompleto", tit: "Quirógano(2)",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "reto", tit: "Reto",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "rocio", tit: "Rocío",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "rojo", tit: "Rojo",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "rosi", tit: "Rosi",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "sandra", tit: "Sandra",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "setevenlospezones", tit: "Pezones",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "sevillana", tit: "Sevillana",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "si", tit: "Sí",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "sillevobragas", tit: "Bragas",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "sombra", tit: "Sombra",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "suda", tit: "Suda",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "talco", tit: "Talco",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "tarantula", tit: "Tarántula",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "tarrastro", tit: "T'arrastro",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "tetas", tit: "Tetas",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "tiendaErotica", tit: "Tienda",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "todos", tit: "Todos",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "toro", tit: "Toro",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "toya", tit: "Toya",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "tracatra", tit: "Tracatrá",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "tresruedas", tit: "Tres Ruedas",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "tuno", tit: "Tú no",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "unaMierda", tit: "Mierda",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "ursula", tit: "Úrsula",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "uy", tit: "Uy!",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "vayais", tit: "Vayáis",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "veniPaCa", tit: "Venid!",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "vida", tit: "Vida",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "vos", tit: "Voz",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),
            ElementoVeneno(arch: "woman", tit: "Woman",cat: "",text: "", col: Utilidades.colores[Int(arc4random_uniform(UInt32(Utilidades.colores.count)))]),

        ]
        
    }
    

    static func capturarElementosVeneno() -> [ElementoVeneno]
    {
        return self.crearElementos()
    }
}

