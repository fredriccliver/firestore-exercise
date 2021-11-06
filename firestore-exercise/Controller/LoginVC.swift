//
//  ViewController.swift
//  firestore-exercise
//
//  Created by Fredric Cliver on 2021/11/07.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class LoginVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    if (Auth.auth().currentUser?.uid) != nil {
      passToMainView()
    }
  }
  
  @IBAction func touchedSignInWithGoogleButton(_ sender: UIButton) {
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    
    // Create Google Sign In configuration object.
    let config = GIDConfiguration(clientID: clientID)
    
    // Start the sign in flow!
    GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
      
      if let error = error {
        print(error)
        return
      }
      
      guard
        let authentication = user?.authentication,
        let idToken = authentication.idToken
      else {
        return
      }
      
      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
      
      
      Auth.auth().signIn(with: credential) { authResult, error in
        if let error = error {
          print(error)
          return
        }
        
        // successful
        self.passToMainView()
        
      }
    }
    
    
    
  }
  
  func passToMainView(){
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let mainTabBarController = storyBoard.instantiateViewController(withIdentifier: "mainTabBarController") as! MainTabBarController
    mainTabBarController.modalPresentationStyle = .fullScreen
    self.present(mainTabBarController, animated: true, completion: nil)
  }
  
}

