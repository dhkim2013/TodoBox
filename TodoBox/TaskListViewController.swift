//
//  TaskListViewController.swift
//  TodoBox
//
//  Created by almond on 2016. 12. 18..
//  Copyright © 2016년 almond. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var editButton: UIBarButtonItem!
    let doneButton: UIBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .done,
        target: nil,
        action: #selector(doneButtonDidTap)
    )
    
    var tasks: [Task] = [] {
        didSet {
            self.saveAll()
            self.editButton.isEnabled = !self.tasks.isEmpty
            self.doneButtonDidTap()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doneButton.target = self
        self.loadAll()
    }
    
    func saveAll() {
        let dicts = self.tasks.map { task -> [String: Any] in
            return [
                "title": task.title,
                "done": task.done,
            ]
        }
        
        UserDefaults.standard.set(dicts, forKey: "tasks")
        UserDefaults.standard.synchronize()
    }
    
    func loadAll() {
        guard let dicts = UserDefaults.standard.array(forKey: "tasks") as? [[String: Any]] else { return }
        self.tasks = dicts.flatMap { dict -> Task? in
            return Task(dictionary: dict)
        }
        self.tableView.reloadData()
        
    }
    
    @IBAction func editButtonDidTab() {
        self.navigationItem.leftBarButtonItem = self.doneButton
        self.tableView.setEditing(true, animated: true)
    }
    
    func doneButtonDidTap() {
        self.navigationItem.leftBarButtonItem = self.editButton
        self.tableView.setEditing(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController,
            let rootViewController = navigationController.viewControllers.first,
            let taskEditViewController = rootViewController as? TaskEditViewController {
            taskEditViewController.didAddTask = { newTask in
                self.tasks.append(newTask)
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = task.memo
        
        if task.done {
            cell.accessoryType = .checkmark
            tasks[indexPath.row].done = true
        }
        
        else {
            cell.accessoryType = .none
            tasks[indexPath.row].done = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = tasks[indexPath.row]
        
        if task.done {
            task.done = false
        }
        
        else {
            task.done = true
        }
        
        tasks[indexPath.row] = task
        
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.tasks.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var newTasks = self.tasks
        let task = self.tasks.remove(at: sourceIndexPath.row)
        newTasks.insert(task, at: destinationIndexPath.row)
        self.tasks = newTasks
    }
}





