//
//  TodoItemTableViewCell.swift
//  firestore-exercise
//
//  Created by Fredric Cliver on 2021/11/07.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
  
  @IBOutlet weak var taskStringLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
