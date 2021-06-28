//
//  ViewController.swift
//  TryFirestore
//
//  Created by Ramzy on 26/06/2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {
    @IBOutlet weak var tasksTableView: UITableView!
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchTasks()
    }

    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        AlertService.addTask(in: self) { task in
            FirestoreManager.shared.create(for: task, in: .tasks)
        }
    }
    
    
    func setupTableView() {
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.registerCellNib(cellClass: TasksCell.self)
    }
    
    func fetchTasks() {
        FirestoreManager.shared.read(from: .tasks, returning: Task.self) { tasks in
            self.tasks = tasks
            self.tasksTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as TasksCell
        cell.configureCell(with: tasks[indexPath.row])
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AlertService.updateTask(tasks[indexPath.row], in: self) { task in
            FirestoreManager.shared.update(for: task, in: .tasks)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        FirestoreManager.shared.delete(tasks[indexPath.row], in: .tasks)
    }
    
}

