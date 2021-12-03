//
//  DataManager.swift
//  cocktails
//
//  Created by Laura Ikic on 01.12.21.
//

import Foundation
import CoreData
// MARK: - Core Data stack
class DataManager{
    // MARK: - Core Data stack

   static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "cocktails")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func favCocktail (title : String, id: String, instructions : String, ingredients: String) -> FavoriteCocktails{
        let cocktail = FavoriteCocktails(context: persistentContainer.viewContext)
        cocktail.title = title
        cocktail.instructions = instructions
        cocktail.id = id
        cocktail.ingredients = ingredients
        return cocktail
    }
    
    func fetchCocktails() -> [FavoriteCocktails]{
        let request: NSFetchRequest = FavoriteCocktails.fetchRequest()
        var fetchedCocktails: [FavoriteCocktails] =  []
        do {
            fetchedCocktails = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching cocktails")
        }
        return fetchedCocktails
    }
    func deleteOneCocktail(cocktail : FavoriteCocktails){
        let context = persistentContainer.viewContext
        context.delete(cocktail)
        do{
            try context.save()
        } catch {
            print("Error deleting cocktail")
        }
    }
    func deleteAllCocktails(cocktails: [FavoriteCocktails]) {
        
        let context = persistentContainer.viewContext
        
        for object in cocktails {
            context.delete(object)
        }
        do{
            try context.save()
        } catch {
            print("Error deleting cocktails")
        }
    }
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
