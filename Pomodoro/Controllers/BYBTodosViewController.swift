import UIKit

class BYBTodosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    var tableView: UITableView!
    var taskTextField: UITextField!
    var addTaskButton: UIButton!
    var tasks: [Task] = []

    var taskTextFieldBottomConstraint: NSLayoutConstraint!
    var addTaskButtonLeadingConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        view.backgroundColor = .white
        title = "Task Management"
        setup()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Set the text field delegate
        taskTextField.delegate = self
    }

    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }

    func setup() {
        
        tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        view.addSubview(tableView)

        taskTextField = UITextField()
        taskTextField.placeholder = "Enter task"
        taskTextField.borderStyle = .roundedRect
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(taskTextField)

        addTaskButton = UIButton(type: .system)
        addTaskButton.setTitle("Add Task", for: .normal)
        addTaskButton.layer.borderColor = UIColor.blue.cgColor // Set the border color
        addTaskButton.layer.borderWidth = 1.0 // Set the border width
        addTaskButton.layer.cornerRadius = 10
        addTaskButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addTaskButton)

        taskTextFieldBottomConstraint = taskTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        taskTextFieldBottomConstraint.isActive = true

        addTaskButtonLeadingConstraint = addTaskButton.leadingAnchor.constraint(equalTo: taskTextField.trailingAnchor, constant: 15)
        addTaskButtonLeadingConstraint.isActive = true

        NSLayoutConstraint.activate([
               taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               taskTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -180),
               taskTextField.heightAnchor.constraint(equalToConstant: 40),

               addTaskButton.centerYAnchor.constraint(equalTo: taskTextField.centerYAnchor),
               addTaskButton.widthAnchor.constraint(equalToConstant: 100),
               addTaskButton.heightAnchor.constraint(equalToConstant: 40),

               // Adjusted leading and trailing constraints to add horizontal padding
               tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               tableView.topAnchor.constraint(equalTo: view.topAnchor),
               tableView.bottomAnchor.constraint(equalTo: taskTextField.topAnchor, constant: -10)
           ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        let task = tasks[indexPath.row]
        cell.titleLabel.text = task.title
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

        // Clear the text field after adding a task
        taskTextField.text = nil
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

    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardHeight = keyboardFrame.size.height

        taskTextFieldBottomConstraint.constant = -keyboardHeight - 10

        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        taskTextFieldBottomConstraint.constant = -80
        addTaskButtonLeadingConstraint.constant = 10

        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    // UITextFieldDelegate method to dismiss the keyboard when return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class TaskCell: UITableViewCell {
    var titleLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        titleLabel = UILabel()
            titleLabel.textAlignment = .left
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
}

struct Task {
    var title: String
}
