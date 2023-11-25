////
////  BYBTodosViewController.swift
////  Pomodoro
////
////  Created by Bekbol Bolatov on 22.11.2023.
////
//
//import UIKit
//
//class BYBTodosViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
//        var tableView: UITableView!
//        var taskTextField: UITextField!
//        var addTaskButton: UIButton!
//        var tasks: [Task] = []
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            view.backgroundColor = .white
//            title = "Task Management"
//            setup()
//        }
//
//        func setup() {
//
//            tableView = UITableView()
//            tableView.translatesAutoresizingMaskIntoConstraints = false
//            tableView.delegate = self
//            tableView.dataSource = self
//            tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoTableViewCell")
//            view.addSubview(tableView)
//
//            taskTextField = UITextField()
//            taskTextField.placeholder = "Enter task"
//            taskTextField.borderStyle = .roundedRect
//            taskTextField.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(taskTextField)
//
//            addTaskButton = UIButton(type: .system)
//            addTaskButton.setTitle("Add Task", for: .normal)
//            addTaskButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
//            addTaskButton.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(addTaskButton)
//
//            NSLayoutConstraint.activate([
//                taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//                taskTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
//                taskTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -180),
//                taskTextField.heightAnchor.constraint(equalToConstant: 40),
//
//                addTaskButton.leadingAnchor.constraint(equalTo: taskTextField.trailingAnchor, constant: 10),
//                addTaskButton.centerYAnchor.constraint(equalTo: taskTextField.centerYAnchor),
//                addTaskButton.widthAnchor.constraint(equalToConstant: 100),
//                addTaskButton.heightAnchor.constraint(equalToConstant: 40),
//
//                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                tableView.topAnchor.constraint(equalTo: view.topAnchor),
//                tableView.bottomAnchor.constraint(equalTo: taskTextField.topAnchor, constant: -10)
//            ])
//        }
//
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return tasks.count
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
//            let task = tasks[indexPath.row]
//            cell.titleLabel.text = task.title
//            cell.checkMark.setImage(UIImage(systemName: task.completed ? "checkmark.circle.fill" : "circle"), for: .normal)
//            cell.checkMark.tintColor = task.completed ? .systemGreen : .systemGray
//            cell.checkMark.addTarget(self, action: #selector(checkmarkTapped(_:)), for: .touchUpInside)
//            cell.selectionStyle = .none
//            return cell
//        }
//
//        @objc func addTask(_ sender: UIButton) {
//            guard let taskTitle = taskTextField.text, !taskTitle.isEmpty else {
//                return
//            }
//
//            let newTask = Task(title: taskTitle)
//            tasks.append(newTask)
//
//
//            let indexPath = IndexPath(row: tasks.count - 1, section: 0)
//            if let tableView = tableView {
//                tableView.insertRows(at: [indexPath], with: .automatic)
//            } else {
//                print("Error: tableView is nil.")
//            }
//        }
//
//        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//            if editingStyle == .delete {
//
//                let alertController = UIAlertController(
//                    title: "Confirm Deletion",
//                    message: "Are you sure you want to delete this task?",
//                    preferredStyle: .alert
//                )
//
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//                alertController.addAction(cancelAction)
//
//                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
//
//                    self.tasks.remove(at: indexPath.row)
//
//
//                    tableView.deleteRows(at: [indexPath], with: .fade)
//                }
//                alertController.addAction(deleteAction)
//
//                present(alertController, animated: true, completion: nil)
//            }
//        }
//
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 55
//        }
//
//
//    @objc func checkmarkTapped(_ sender: UIButton) {
//        guard let cell = sender.superview as? ToDoTableViewCell,
//              let indexPath = tableView.indexPath(for: cell) else {
//            return
//        }
//        tasks[indexPath.row].completed.toggle()
//        let imageName = tasks[indexPath.row].completed ? "circle.fill" : "circle"
//        cell.checkMark.setImage(UIImage(systemName: imageName), for: .normal)
//        tableView.reloadRows(at: [indexPath], with: .none)
//    }
//}
//
//    struct Task {
//        var title: String
//        var completed: Bool =  false
//    }
//
import UIKit

class BYBTodosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView!
    var taskTextField: UITextField!
    var addTaskButton: UIButton!
    var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Task Management"
        setup()
    }

    func setup() {

        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoTableViewCell")
        view.addSubview(tableView)

        taskTextField = UITextField()
        taskTextField.placeholder = "Enter task"
        taskTextField.borderStyle = .roundedRect
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(taskTextField)

        addTaskButton = UIButton(type: .system)
        addTaskButton.setTitle("Add Task", for: .normal)
        addTaskButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addTaskButton)

        NSLayoutConstraint.activate([
            taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            taskTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            taskTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -180),
            taskTextField.heightAnchor.constraint(equalToConstant: 40),

            addTaskButton.leadingAnchor.constraint(equalTo: taskTextField.trailingAnchor, constant: 10),
            addTaskButton.centerYAnchor.constraint(equalTo: taskTextField.centerYAnchor),
            addTaskButton.widthAnchor.constraint(equalToConstant: 100),
            addTaskButton.heightAnchor.constraint(equalToConstant: 40),

            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: taskTextField.topAnchor, constant: -10)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as! ToDoTableViewCell
        let task = tasks[indexPath.row]
        cell.titleLabel.text = task.title
        cell.checkMark.setImage(UIImage(systemName: task.completed ? "checkmark.circle.fill" : "circle"), for: .normal)
        cell.checkMark.tintColor = task.completed ? .systemGreen : .systemGray
        cell.selectionStyle = .none
        return cell
    }

    @objc func addTask(_ sender: UIButton) {
        guard let taskTitle = taskTextField.text, !taskTitle.isEmpty else {
            return
        }

        let newTask = Task(title: taskTitle)
        tasks.append(newTask)

        let indexPath = IndexPath(row: tasks.count - 1, section: 0)
        if let tableView = tableView {
            tableView.insertRows(at: [indexPath], with: .automatic)
        } else {
            print("Error: tableView is nil.")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DID SELECT ROW AT")
        tasks[indexPath.row].completed = !tasks[indexPath.row].completed
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let alertController = UIAlertController(
                title: "Confirm Deletion",
                message: "Are you sure you want to delete this task?",
                preferredStyle: .alert
            )

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)

            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in

                self.tasks.remove(at: indexPath.row)

                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            alertController.addAction(deleteAction)

            present(alertController, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

//    @objc func checkmarkTapped(_ sender: UIButton) {
//        guard let cell = sender.superview as? ToDoTableViewCell,
//              let indexPath = tableView.indexPath(for: cell) else {
//            return
//        }
//        tasks[indexPath.row].completed.toggle()
//        let imageName = tasks[indexPath.row].completed ? "checkmark.fill" : "circle"
//        cell.checkMark.setImage(UIImage(systemName: imageName), for: .normal)
//        tableView.reloadRows(at: [indexPath], with: .none)
//    }
}

struct Task {
    var title: String
    var completed: Bool = false
}
