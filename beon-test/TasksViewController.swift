//
//  TasksViewController.swift
//  beon-test
//
//  Created by Marco Braga on 29/08/23.
//

//Main screen:
//A simple list of tasks which will be empty at the beginning.
//There should be an Add button to add new items to the list. Tapping the button should send the user to the following 'add task' screen.
//Items must be checkable, and swipe-to-delete deletable
//Add task screen:
//This screen should let the user pick a title, a description text, a date (to indicate a deadline) and whether the task has been completed or not.
//After adding the task,
// the user should be sent back to the main screen

import UIKit

final class TasksViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Public properties

    // MARK: - Private properties
    private var tasks = [Task]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add-task" {
            let addTaskVC = segue.destination as? AddTaskViewController
            addTaskVC?.delegate = self
        }
    }

    // MARK: Private functions

    private func setupViews() {
        let item = UIBarButtonItem(image: .add,
                                   style: .plain,
                                   target: self,
                                   action: #selector(addTask))
        navigationItem.setRightBarButton(item, animated: true)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }

    @objc private func addTask() {
        performSegue(withIdentifier: "add-task", sender: self)
    }
}

// MARK: - AddTaskViewControllerDelegate

extension TasksViewController: AddTaskViewControllerDelegate {
    func didCreate(task: Task) {
        tasks.append(task)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "task-cell", for: indexPath) as? TaskCell {
            cell.setupCell(task: tasks[indexPath.row])
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
