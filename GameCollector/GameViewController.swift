//
//  GameViewController.swift
//  GameCollector
//
//  Created by Tim Aton on 6/5/18.
//  Copyright © 2018 Tim Aton. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var game : Game? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        //change the UI elements based on if it's new or editing an existing
        if game != nil {
            gameImageView.image = UIImage(data: game!.image as! Data)
            titleTextField.text = game?.title
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        //user can choose from all photos
        //remeber to add the privacy ask in the info.plist
        imagePicker.sourceType = .photoLibrary
        
        //allows an image picker VC to pop on top
        present(imagePicker, animated: true, completion: nil)
    }
    
    //set the image that the user chose to the game image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        gameImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
        //"open" CoreData
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let game = Game(context: context)
        
        //change the attributes of this game to what the user chooses
        game.title = titleTextField.text
        game.image = UIImagePNGRepresentation(gameImageView.image!)
        
        //save back to CoreData
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        //pop back to list screen
        navigationController!.popViewController(animated: true)
    }
}
