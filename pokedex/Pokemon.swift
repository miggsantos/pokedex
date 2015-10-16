//
//  Pokemon.swift
//  pokedex
//
//  Created by Miguel Santos on 13/10/15.
//  Copyright © 2015 Miguel Santos. All rights reserved.
//

import Foundation
import Alamofire

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
    private var _nextEvolutionId:String!
    private var _nextEvolutionLvl:String!
    private var _pokemonUrl: String!
    
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    var description: String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var type: String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var defense: String{
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    var height: String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var weight: String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var attack: String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String{
        if _nextEvolutionTxt == nil{
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionId: String{
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLvl: String{
        if _nextEvolutionLvl == nil{
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }
    
    
    init(name: String, pokedexId: Int ){
        self._pokedexId = pokedexId
        self._name = name
        
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
        
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {

        let url = NSURL(string: _pokemonUrl)!
        
        Alamofire.request(.GET, url).responseJSON{ (response) -> Void in
            
            if let dic = response.result.value as? Dictionary<String,AnyObject> {
                
                if let weight = dic["weight"] as? String {
                    self._weight = weight
                }
                if let height = dic["height"] as? String {
                    self._height = height
                }
                if let attack = dic["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dic["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let types = dic["types"] as? [Dictionary<String,String>] where types.count > 0{
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                    
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                
                } else {
                    self._type = ""
                }
                
                if let descriptions = dic["descriptions"] as? [Dictionary<String,String>] where descriptions.count > 0{
                    
                    if let url = descriptions[0]["resource_uri"] {
                        
                        let nsUrl = NSURL(string: "\(URL_BASE)\(url)")!
                        
                        Alamofire.request(.GET, nsUrl).responseJSON(completionHandler: { (response) -> Void in
                            if let descDict = response.result.value as? Dictionary<String,AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    //print(self._description)
                                }
                            
                            }
                            
                            completed()  // 
                            
                        })
                        
                        
                    }
                    
                } else {
                    self._description = ""
                }
                
                if let evolutions = dic["evolutions"] as? [Dictionary<String,AnyObject>] where evolutions.count > 0{
                    
                    if let to = evolutions[0]["to"] as? String {
                        
                        //mega not supported but in exist in api
                        if to.rangeOfString("mega") == nil {
                        
                            if let uri = evolutions[0]["resource_uri"] as? String {
                            
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon", withString:"")
                                
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString:"")

                                self._nextEvolutionId = num
                                self._nextEvolutionTxt = to
                            
                                if let lvl = evolutions[0]["level"] as? Int {
                                
                                    self._nextEvolutionLvl = "\(lvl)"
                                }
                                
                            }
                        
                        }
                    }
                    
                    
                    if let url = evolutions[0]["resource_uri"] {
                        
                        let nsUrl = NSURL(string: "\(URL_BASE)\(url)")!
                        
                        Alamofire.request(.GET, nsUrl).responseJSON(completionHandler: { (response) -> Void in
                            if let descDict = response.result.value as? Dictionary<String,AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(self._description)
                                }
                                
                            }
                        })
                        
                        
                    }
                    
                    
                    
                } else {
                    self._description = ""
                }
                
                
                
                //print(self._weight)
                //print(self._height)
                //print(self._attack)
                //print(self._defense)
                //print(self._type)
                
            }
            
            
        }
        
        
        
    }
    
    
}
