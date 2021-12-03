//
//  Recipes.swift
//  cocktails
//
//  Created by Laura Ikic on 26.11.21.
//

import Foundation

struct Recipes: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case recipes = "drinks"
    }
    
    let recipes: [ String : [String?] ]
}

struct Recipe: Decodable {
    let title: String
    let instructions: String
    let image: URL?
    let ID: String
    var ingredientsList: [String?] = []
    
    enum RecipeKeys: String, CodingKey {
        case image = "strDrinkThumb"
        case title = "strDrink"
        case instructions = "strInstructions"
    }
}


