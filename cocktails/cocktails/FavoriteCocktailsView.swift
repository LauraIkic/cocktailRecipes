//
//  FavoriteCocktailsView.swift
//  cocktails
//
//  Created by Laura Ikic on 30.11.21.
//

import Foundation
import UIKit
import CoreData

class FavoriteCocktailsView: UIViewController {
  public let cellIdentifier: String = "recipeIdentifier"
  public var favoirteCocktailItems: [FavoriteCocktails] = []
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "hawaii.jpg")!)
        tableView.dataSource = self
        tableView.delegate = self
        
        favoirteCocktailItems = DataManager.shared.fetchCocktails()
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSelectedRecipe",
           let destination = segue.destination as? RecipeViewController,
           let recipeCell = sender as? RecipeCell,
           let indexPath = tableView.indexPath(for: recipeCell) {
            let cocktailItem = favoirteCocktailItems[indexPath.row]
            destination.favoriteCocktailItem = cocktailItem
        }
    }

    @IBAction func deleteSavedCocktails(_ sender: Any) {
        DataManager.shared.deleteAllCocktails(cocktails: favoirteCocktailItems)
        DataManager.shared.saveContext()
        favoirteCocktailItems.removeAll()
        tableView.reloadData()
    }
    public func deleteCocktail(cocktail: FavoriteCocktails){
        DataManager.shared.deleteOneCocktail(cocktail: cocktail)
        DataManager.shared.saveContext()
    }
}

extension FavoriteCocktailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoirteCocktailItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let recipe = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipeCell else {
           fatalError("Could not create RecipeCell")
       }
       let recipeItem = favoirteCocktailItems[indexPath.row]
       recipe.recipeLabel.text = recipeItem.title
       //TO DO include image
       return recipe
   }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let cell = favoirteCocktailItems.remove(at: indexPath.row)
                deleteCocktail(cocktail:cell)            }
        tableView.reloadData()
    }
}
extension FavoriteCocktailsView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
