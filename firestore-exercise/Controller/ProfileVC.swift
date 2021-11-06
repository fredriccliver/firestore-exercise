//
//  profileVC.swift
//  firestore-exercise
//
//  Created by Fredric Cliver on 2021/11/07.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {
  
  @IBOutlet weak var emailLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presentUserInfo()
  }
  
  @IBAction func touchedLogoutButton(_ sender: UIButton) {
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
      dismiss(animated: true) {
        
      }
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
    
  }
  
  func presentUserInfo(){
    if let email = Auth.auth().currentUser?.email {
      emailLabel.text = email
    }else{
      emailLabel.text = ""
    }
  }
  
  
}
