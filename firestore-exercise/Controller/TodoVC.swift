//
//  todoVC.swift
//  firestore-exercise
//
//  Created by Fredric Cliver on 2021/11/07.
//

import UIKit

class TodoVC: UIViewController {
  
  @IBOutlet weak var newItemTextField: UITextField!
  @IBOutlet weak var todoListTableView: UITableView!
  var todoItems:[ToDoItem]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    newItemTextField.delegate = self
    todoListTableView.dataSource = self
    
    getTodoItems()
  }
  
  func getTodoItems(){
    ToDoAPI.readItems { todoItems, error in
      guard todoItems != nil else {
        return
      }
      self.todoItems = todoItems
      self.todoListTableView.reloadData()
      
    }
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
              self.getTodoItems()
            }
          }
        }
        
      }
      return true
    }
}


extension TodoVC: UITableViewDelegate, UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    todoItems?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // create a new cell if needed or reuse an old one
    let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell") as! TodoItemTableViewCell
    
    // set the text from the data model
    cell.taskStringLabel.text = todoItems?[indexPath.row].task
    
    return cell
  }
  
}



