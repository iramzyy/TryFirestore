//
//  AlertService.swift
//  TryFirestore
//
//  Created by Ramzy on 27/06/2021.
//

import UIKit

class AlertService {
    private init() {}
    
    static func addTask(in viewController: UIViewController, completion: @escaping (Task) -> Void) {
        let alert = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        alert.addTextField { taskTitleTextField in
            taskTitleTextField.placeholder = "Task Title"
        }
        
        alert.addTextField { taskDescriptionTextField in
            taskDescriptionTextField.placeholder = "Task Description"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let title = alert.textFields?.first?.text,
                  let description = alert.textFields?.last?.text
            else {return}
            
            let task = Task(taskTitle: title, taskDescription: description)
            completion(task)
        }
        alert.addAction(addAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func updateTask(_ task: Task,in viewController: UIViewController, completion: @escaping (Task) -> Void) {
        let alert = UIAlertController(title: "Update Task", message: nil, preferredStyle: .alert)
        alert.addTextField { taskTitleTextField in
            taskTitleTextField.placeholder = "Task Title"
            taskTitleTextField.text = task.title
        }
        
        alert.addTextField { taskDescriptionTextField in
            taskDescriptionTextField.placeholder = "Task Description"
            taskDescriptionTextField.text = task.description
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let title = alert.textFields?.first?.text,
                  let description = alert.textFields?.last?.text
            else {return}
            
            var updatedTask = task
            updatedTask.title = title
            updatedTask.description = description
            completion(updatedTask)
        }
        alert.addAction(addAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
