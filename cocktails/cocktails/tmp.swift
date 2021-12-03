//
//  tmp.swift
//  cocktails
//
//  Created by Laura Ikic on 02.12.21.
//

import Foundation
/*
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
     
     
     override func viewDidLoad() {
         super.viewDidLoad()
         if(cocktailItem != nil){
             var favItem : FavoriteCocktails!
             favItem = getEquivalendCocktailItem()
             if (favItem != nil){
                setLikedImage(liked: false)
             }else{
                 liked = false
             }
             recipeTitle.text = cocktailItem.title
             recipeDescription.text = cocktailItem.instructions
             ID = cocktailItem.ID
         }
         if (favoriteCocktailItem != nil){
             liked = true
             setLikedImage(liked: true)
             recipeTitle.text = favoriteCocktailItem.title
             recipeDescription.text = favoriteCocktailItem.instructions
             ID = favoriteCocktailItem.id ?? "00"
         }
     }
     
     
     
     @IBAction func saveRecipe(_ sender: Any) {
         if (liked){
             //Save to favs in core data
             if(favoriteCocktailItem == nil){
                 favoriteCocktailItem = getEquivalendCocktailItem()
                 DataManager.shared.deleteOneCocktail(cocktail: favoriteCocktailItem)
                 DataManager.shared.saveContext()
                 print("deleted")
                 setLikedImage(liked: false)
                 liked = false
             }
         } else {
             //delete form CoreData
             if (cocktailItem != nil){
                 let cockatail = DataManager.shared.favCocktail(title: cocktailItem.title, id: cocktailItem.ID, instructions: cocktailItem.instructions)
                  DataManager.shared.saveContext()
                 setLikedImage(liked: true)
                 liked = true
                 print("saved")
             }
             }
         }
     
     func getEquivalendCocktailItem() -> FavoriteCocktails? {

         favoirteCocktailItems = DataManager.shared.fetchCocktails()
         for item in favoirteCocktailItems{
             if (item.id == cocktailItem.ID){
                 print("found item = liked")
                 setLikedImage(liked: true)
                 liked = true
                 return item
             }
         }
         return nil
     }
     func setLikedImage(liked: Bool) {
         if (liked){
             likeButton.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.normal)
             print("heart filled")
             return
         } else {
             likeButton.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
             return
         }
     }
 }


 */
