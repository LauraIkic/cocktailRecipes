//
//  RecipeDetails.swift
//  cocktails
//
//  Created by Laura Ikic on 27.11.21.
//

import Foundation
import UIKit
struct RecipeDetails: Decodable {
    // let recipeDetails: [[String: String?]]
    let recipe: [String : String?]
    
    enum CodingKeys: String, CodingKey {
        case drinksDetails = "drinks"
    }
    
    
}

extension RecipeDetails {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var recipe: [String: String?] = [:]
        do {
            let dictionary = try container.decode([[String: String?]].self, forKey: .drinksDetails)
          
            if dictionary != nil {
                recipe = dictionary.first ?? ["Leer" : "Leer" ]
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        self.init(recipe: recipe)
    }
}



