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
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
           
            performSegue(withIdentifier: "showUserTable", sender: self)
        }
    }
    
    
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
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if signupMode {
                //Sign Up 
                
                let user = PFUser()
                
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackground(block: { (success, error) in
                    
                self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try again later."
                        if let errorMessage = error as? NSError {
                            displayErrorMessage = errorMessage.userInfo["error"] as! String
                        }
                        self.createAlert(title: "Signup Error", message: displayErrorMessage)
                    } else {
                        print("user already signed up")
                        
                       self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                
                })
            
            } else {
              
                //Login Mode
                
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try again later."
                        if let errorMessage = error as? NSError {
                            displayErrorMessage = errorMessage.userInfo["error"] as! String
                        }
                        self.createAlert(title: "Login Error", message: displayErrorMessage)

                    } else {
                        
                        print("Logged in")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)

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
            signupMode = false
            
        } else {
            //Change signup mode 
            
            signupButton.setTitle("Sign Up", for: [])
            changSignupModeButton.setTitle("Log In", for: [])
            messageLabel.text = "Already have an account?"
            signupMode = true
        
        }
    }
    
    
    
}
