//
//  SignUpViewController.swift
//  CustomLoginDemo
//
//  Created by Lorenzo McDaniel on 12/14/19.
//  Copyright © 2019 Lorenzo McDaniel. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
  
    
    }
    
    func setUpElements() {
        
        // hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    
    }
    
    // check the fields and validate that the data is correct.
    // if it is correct this method returns nil. otherwise
    // it returns the error message
    func validateFields() -> String? {
        
        // check that all fields filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        
        // check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
        
    }


    
    @IBAction func signUpTapped(_ sender: Any) {
        
    
    // validate the fields
    let error = validateFields()
    
    if error != nil {
    
    // theres something wrong with the fields , show error message
        showError(error!)
    }
        else
    {
        
        // create cleaned version of the data strip whitespace and new lines from text field
                  let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                  let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                  let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                  let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
    //create the user
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            // check for errors
            if err != nil {
                
                // there was an error creating user
                self.showError("Error creating user")
                
            }
            
            
            else{
                

                // user was create successfully , now store the first and last name
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid]) { (error) in
                    
                    if error != nil {
                        // show error message
                        self.showError("error saving user data")
                    }
                }
          
                // transition to home screen
                self.transitionToHome()
            
            }
        }

        }
}

    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.StoryBoard.homeViewController) as?
        HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    
    
    // transition to the home screen
       func showError(_ message:String) {
           
           errorLabel.text = message
           errorLabel.alpha = 1
       }

}
