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
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
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
    }
}
