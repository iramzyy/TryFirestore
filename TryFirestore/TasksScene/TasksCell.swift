//
//  TasksCell.swift
//  TryFirestore
//
//  Created by Ramzy on 27/06/2021.
//

import UIKit

class TasksCell: UITableViewCell {
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configureCell(with task: Task) {
        taskTitleLabel.text = task.title
        taskDescriptionLabel.text = task.description
    }
}
