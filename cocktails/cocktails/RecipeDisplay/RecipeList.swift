//
//  RecipeList.swift
//  cocktails
//
//  Created by Laura Ikic on 24.11.21.
//

import Foundation
import UIKit
import SwiftUI

class RecipeList: UIViewController {
    private let cellIdentifier = "recipeIdentifier"
    private let urlSession = URLSession.shared
    @IBOutlet var tableView: UITableView!
    
    private enum NetworkError: Error {
        case unexpectedError
        case couldNotFindURL
        case couldNotFindResonseData
    }
    public var recipeItems: [Recipe] = []
 //   private var cocktailItem = [Recipe]()
 //   var recipeDictionary: [[String: String?]] = []
    
    @IBOutlet weak var searchCocktail: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "hawaii.jpg")!)
        searchCocktail.enablesReturnKeyAutomatically = true
        searchCocktail.showsSearchResultsButton = true
        
        tableView.dataSource = self
        tableView.delegate = self

    }

    
    @IBAction func searchEntered(_ sender: Any) {
 
        guard let cocktailTitle = searchCocktail.text else {return  } //TO DO: error pop up not found
        getCocktailData(for: cocktailTitle.lowercased(), completion: { [weak self] responeData, error in
            guard let items = responeData else { return }
            guard let name = items.recipe["strDrink"] else { return }
            guard let name = name else { return }
            
            guard let instructions = items.recipe["strInstructions"] else { return }
            guard let instructions = instructions else { return }
            
            guard let imageURL = items.recipe["strDrinkThumb"] else { return }
            guard let imageURL = imageURL else { return }
            guard let imageURL = URL(string: imageURL) else { return }
            
            guard let cocktailID = items.recipe["idDrink"] else { return }
            guard let cocktailID = cocktailID else {return }
            
            
            var ingredientsList: [String?] = []
      
            for index in 1...3{
                guard let ingredient = items.recipe["strIngredient\(index)"] else { return}
                guard let ingredient = ingredient else { return}
                if(ingredient == nil){
                    return
                } else {
                    ingredientsList.insert(ingredient, at: 0)
                }
             
            }
            for item in ingredientsList{
                print(item)
            }
            
            
            //TO DO get if saved
            self?.recipeItems.insert(Recipe(title: name , instructions: instructions, image: imageURL, ID : cocktailID, ingredientsList: ingredientsList), at: 0)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSelectedRecipe",
           let destination = segue.destination as? RecipeViewController,
           let recipeCell = sender as? RecipeCell,
           let indexPath = tableView.indexPath(for: recipeCell) {
            let cocktailItem = recipeItems[indexPath.row]
            destination.cocktailItem = cocktailItem
        }
    }
    
    
    //get Data from API
    private func getCocktailData(for title: String, completion: @escaping (RecipeDetails?, Error?) -> Void) {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(title)&api_key=1")
        else {
            completion(nil, NetworkError.couldNotFindURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, respone, error in
            if error != nil {
                completion(nil, error)
            }
            guard let responseData =  data else {
                completion(nil, NetworkError.couldNotFindResonseData )
                return
            }
            let decoder = JSONDecoder()
            do {
                let recipe = try decoder.decode(RecipeDetails.self, from: responseData)
                // print(recipe)
                completion(recipe, nil)
            } catch {
                completion(nil, error)
            }
            
            
        })
        task.resume()
        
    }
}
extension RecipeList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let recipe = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipeCell else {
           fatalError("Could not create RecipeCell")
       }
       let recipeItem = recipeItems[indexPath.row]
       recipe.recipeLabel.text = recipeItem.title
       //TO DO include image
       return recipe
   }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                recipeItems.remove(at: indexPath.row)
            }
        tableView.reloadData()
    }
}
extension RecipeList: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

