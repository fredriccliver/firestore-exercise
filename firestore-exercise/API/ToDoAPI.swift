//
//  TodoAPI.swift
//  firestore-exercise
//
//  Created by Fredric Cliver on 2021/11/07.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ToDoAPI {
  
  static func addNewItem (task:String, complete: @escaping (_ error:Error?)-> ()){
    
    let db = Firestore.firestore()
    guard let me = Auth.auth().currentUser else{
      print("User is unidentifiable")
      return
    }
    
    let docData: [String: Any] = [
      "task": task,
      "owner": me.uid,
      "date": Timestamp(date: Date()),
    ]
    
    db.collection("todo").addDocument(data: docData) { err in
      if let err = err {
        print("Error writing document: \(err)")
        complete(err)
      } else {
        print("Document successfully written!")
        complete(nil)
      }
      
    }
  }
  
  static func readItems(complete: @escaping (_ todoItems:[ToDoItem]?, _ error:Error?)-> ()){
    
    let db = Firestore.firestore()
    guard let me = Auth.auth().currentUser else{
      print("User is unidentifiable")
      return
    }
    
    db.collection("todo").whereField("owner", isEqualTo: me.uid)
      .getDocuments() { (querySnapshot, err) in
        if let err = err {
          complete(nil, NSError(domain: "Couldn't get todo items \(err)", code: 400, userInfo: nil))
        } else {
          
          let dataDictionary = querySnapshot!.documents.compactMap { queryDocumentSnapshot -> ToDoItem? in
            
            var items = try? queryDocumentSnapshot.data(as: ToDoItem.self)
            items?._id = queryDocumentSnapshot.documentID
            
            return items
          }
          
          complete(dataDictionary, nil)
          
          
        }
      }
    
  }
  
}
