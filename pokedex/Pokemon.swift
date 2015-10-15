//
//  Pokemon.swift
//  pokedex
//
//  Created by Miguel Santos on 13/10/15.
//  Copyright © 2015 Miguel Santos. All rights reserved.
//

import Foundation

class Pokemon {

    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvolutionTxt:String!
    
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    
    
    
    
    
    
    init(name: String, pokedexId: Int ){
        self._pokedexId = pokedexId
        self._name = name
    }
    
}
