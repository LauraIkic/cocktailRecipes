//
//  RecipeViewController.swift
//  cocktailsr
//
//  Created by Laura Ikic on 26.11.21.
//

import Foundation
import UIKit
import CoreData


class RecipeViewController: UIViewController {
    
    var cocktailItem : Recipe!
    var favoriteCocktailItem: FavoriteCocktails!
    public var favoirteCocktailItems: [FavoriteCocktails] = []
    var ID: String = ""
    public var liked: Bool = false
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var ingredients: UILabel!
    var listIngredients: String = " "
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if(cocktailItem != nil){
            var favItem : FavoriteCocktails!
            favItem = getEquivalendCocktailItem()
            if (favItem != nil){
               setLikedImage()
            }else{
                setDisLikedImage()
            }
            recipeTitle.text = cocktailItem.title
            recipeDescription.text = cocktailItem.instructions
            ID = cocktailItem.ID
            
            if (cocktailItem.ingredientsList != nil){
                for item in cocktailItem.ingredientsList {
                    listIngredients.append(contentsOf: "\u{2022}")
                    listIngredients.append(contentsOf: item!)
                    listIngredients.append(contentsOf: "\n")
                }
            }

            ingredients.text = listIngredients
        }
        if (favoriteCocktailItem != nil){
            setLikedImage()
            recipeTitle.text = favoriteCocktailItem.title
            recipeDescription.text = favoriteCocktailItem.instructions
            ID = favoriteCocktailItem.id ?? "00"
            ingredients.text = favoriteCocktailItem.ingredients
        }
    }
    
    
    
    @IBAction func saveRecipe(_ sender: Any) {
        if (liked){
            //Delete from core data
            if(favoriteCocktailItem == nil){
                favoriteCocktailItem = getEquivalendCocktailItem()
            }
                DataManager.shared.deleteOneCocktail(cocktail: favoriteCocktailItem)
                DataManager.shared.saveContext()
                print("deleted")
                setDisLikedImage()
          
        } else {
            //save to core data
            if (cocktailItem != nil){
                let cockatail = DataManager.shared.favCocktail(title: cocktailItem.title, id: cocktailItem.ID, instructions: cocktailItem.instructions, ingredients: listIngredients)
                 DataManager.shared.saveContext()
                print("saved")
                setLikedImage()
                }
            }
        
        }
    
    func getEquivalendCocktailItem() -> FavoriteCocktails? {
        favoirteCocktailItems = DataManager.shared.fetchCocktails()
        for item in favoirteCocktailItems{
            if (item.id == cocktailItem.ID){
                print("found item = liked")
                setLikedImage()
                return item
            }
        }
        return nil
    }
    func setLikedImage() {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
            liked = true
            print("heart filled")
    }
    func setDisLikedImage() {
        likeButton.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
        liked = false
        print("not filled")
    }
}

