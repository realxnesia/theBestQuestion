//
//  HomeViewController.swift
//  theBestQuestion
//
//  Created by DHIKA ADITYA ARE on 27/04/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableCategory: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayOfCategory = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableCategory.delegate = self
        tableCategory.dataSource = self
        viewHome()
        
        getCategoryFromCoreData()

    }
    
    func viewHome(){
        tableCategory.backgroundColor = UIColor.clear
    }
    
    func getCategoryFromCoreData(){
//        do {
//            self.arrayOfCategory = try context.fetch(Category.fetchRequest())
//            DispatchQueue.main.async {
//                self.tableCategory.reloadData()
//            }
//        } catch  {
//        }
        do{
            arrayOfCategory = try context.fetch(Category.fetchRequest())
        }catch{
        }
        
        do {
            try context.save()
        } catch {
        }
    }
        
    
    //MARK: Setting table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kategoriCell", for: indexPath)
        let data = self.arrayOfCategory[indexPath.row]
        cell.textLabel?.text = data.listOfCategory
        
        return cell
    }
    
    //MARK: Klik table (delegate methode)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToStory", sender: self)
        
        //MARK: Navigation
//        let vc = StoryQuestViewController()
//        vc.navigationItem.largeTitleDisplayMode = .never
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="goToStory"){
            let destinationVC = segue.destination as! StoryQuestViewController
            if let indexPath = tableCategory.indexPathForSelectedRow{
                destinationVC.selectedCategory = arrayOfCategory[indexPath.row]
                //destinationVC.kategoriApetu = String(arrayOfCategory[indexPath.row])
            }
        }
    }
}
