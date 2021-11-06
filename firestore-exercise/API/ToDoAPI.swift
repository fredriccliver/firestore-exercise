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
      } else {
        print("Document successfully written!")
      }
    }
  }
  
  static func readItems(){
    
    let db = Firestore.firestore()
    guard let me = Auth.auth().currentUser else{
      print("User is unidentifiable")
      return
    }
    
    db.collection("todo").whereField("owner", isEqualTo: me.uid)
      .getDocuments() { (querySnapshot, err) in
        if let err = err {
          print("Error getting documents: \(err)")
        } else {
          for document in querySnapshot!.documents {
            print("\(document.documentID) => \(document.data())")
          }
        }
      }
    
  }
  
}
