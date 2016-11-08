//
//  PostViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Travis Sasselli on 11/8/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @IBOutlet var imageToPost: UIImageView!
    @IBOutlet var messageTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func chooseAnImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
        
            imageToPost.image = image
            
        }
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func postImage(_ sender: Any) {
       
        var post = PFObject(className: "Posts")

        post["message"] = messageTextField.text
        
        post["userId"] = PFUser.current()?.objectId
        
        let imageData = UIImagePNGRepresentation(imageToPost.image!)
        
        let imageFile = PFFile(name: "image.png", data: imageData!)
        
        post["imageFile"] = imageFile
        
        post.saveInBackground { (success, error) in
            
            if error != nil {
                
                self.createAlert(title: "could not post Image", message: "Please try again later")
                
            } else {
            
            self.createAlert(title: "Image was posted successfully", message: "")
                
                self.messageTextField.text = ""
                
                self.imageToPost.image = UIImage(named: "default.png")
                
        }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
