//
//  LoginViewController.swift
//  CustomLoginDemo
//
//  Created by Lorenzo McDaniel on 12/14/19.
//  Copyright © 2019 Lorenzo McDaniel. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

   
    
    @IBOutlet weak var emailfirstNameTextField: UITextField!
    
    
    
    @IBOutlet weak var passwordlastNameTextField: UITextField!
    
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
    }
    
    func setUpElements() {
        
        // hide the error label
        errorLabel.alpha = 0
        
        // style the elements
        Utilities.styleTextField(emailfirstNameTextField)
        Utilities.styleTextField(passwordlastNameTextField)
        Utilities.styleFilledButton(loginButton)
         
    }
 
    
    
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
    
    
    // validate text fields
    
    
    // create cleaned version of the text
        let email = emailfirstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let password = passwordlastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        
        
    // signing in the user
    
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            
            if error != nil {
                
                // couldnt sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            
            }
            
            
            else
            {
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.StoryBoard.homeViewController) as?
                    HomeViewController
                    
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                }
                
                
                
            }
            
            
            
            
        }
    }
    
    
    
    
    
    
    

