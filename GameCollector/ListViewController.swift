//
//  ListViewController.swift
//  GameCollector
//
//  Created by Tim Aton on 6/5/18.
//  Copyright © 2018 Tim Aton. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var outfits : [Outfit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //get the outfits from CoreData
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            outfits = try context.fetch(Outfit.fetchRequest())
            tableView.reloadData()
        } catch {
            
        }
        
    }
    
    //how many rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outfits.count
    }
    
    //what's in each row/cell of the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let outfit = outfits[indexPath.row]
        
        //show label in list
        cell.textLabel?.text = "Last worn: \(outfit.date!)"
        
        //show image in list
        cell.imageView?.image = UIImage(data: outfit.image as! Data)
        
        return cell
    }
    
    //pass the outfit the user selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let outfit = outfits[indexPath.row]
        performSegue(withIdentifier: "gameSegue", sender: outfit)
    }
    
    //go to outfit VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! OutfitViewController
        nextVC.outfit = sender as? Outfit
    }
    
}
