//
//  todoVC.swift
//  firestore-exercise
//
//  Created by Fredric Cliver on 2021/11/07.
//

import UIKit

class TodoVC: UIViewController {
  
  @IBOutlet weak var newItemTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    newItemTextField.delegate = self
  }
  
  
}

extension TodoVC: UITextFieldDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      if textField == newItemTextField {
        // slide off keyboard
        newItemTextField.resignFirstResponder()
        
        if let task = newItemTextField.text {
          ToDoAPI.addNewItem(task: task) { error in
            if error == nil {
              ToDoAPI.readItems()
            }
          }
        }
        
      }
      return true
    }
}


extension TodoVC: UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    <#code#>
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    <#code#>
  }
  
}



