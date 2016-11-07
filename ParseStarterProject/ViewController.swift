/**
 * Copyright (c) 2015-present, Parse, LLC.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var changSignupModeButton: UIButton!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var signupButton: UIButton!
    
    var signupMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func signupOrLogin(_ sender: Any) {
        
        if emailTextField.text! == "" || passwordTextField.text! == "" {
           createAlert(title: "Error in form", message: "Please enter an email and password")
        
        } else {
            if signupMode {
                //Sign Up 
                
                let user = PFUser()
                
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackground(block: { (success, error) in
                    
                    if error != nil {
                        print(error)
                       
                        self.createAlert(title: "Error in form", message: "Parse Error")
                        
                    }
                })
            }
        }
        
        
    }
    
    
    @IBAction func changeSignupMode(_ sender: Any) {
        if signupMode {
            // Change to login mode
            signupButton.setTitle("Log In", for: [])
            
            changSignupModeButton.setTitle("Sign Up", for: [])
            
            messageLabel.text = "Don't have an account?"
            
        } else {
            //Change signup mode 
            
            signupButton.setTitle("Sign UP", for: [])
            changSignupModeButton.setTitle("Sign Up", for: [])
            messageLabel.text = "Already have an account?"
            signupMode = true
        
        }
    }
    
}
