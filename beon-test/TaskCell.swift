//
//  TaskCell.swift
//  beon-test
//
//  Created by Marco Braga on 29/08/23.
//

import UIKit

final class TaskCell: UITableViewCell {

    @IBOutlet weak var contentTextView: UITextView!

    var task: Task?

    func setupCell(task: Task) {
        self.task = task
        contentTextView.text = "\(task.title) \n \(task.description) \n \(task.formattedDeadline) \n Completed? \(task.isCompleted)"
    }
    
}
