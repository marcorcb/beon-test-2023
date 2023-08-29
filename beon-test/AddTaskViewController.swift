//
//  AddTaskViewController.swift
//  beon-test
//
//  Created by Marco Braga on 29/08/23.
//

import UIKit

protocol AddTaskViewControllerDelegate: AnyObject {
    func didCreate(task: Task)
}

final class AddTaskViewController: UIViewController {

    // MARK: - @IBOutlets

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var deadlineTextField: UITextField!
    @IBOutlet weak var completedSwitch: UISwitch!

    // MARK: - Public properties
    weak var delegate: AddTaskViewControllerDelegate?

    // MARK: - Private properties

    private var selectedDeadline: Date?
    private let dateFormatter = DateFormatter()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: - Private functions

    private func setupViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        deadlineTextField.inputView = picker
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func fieldsAreValid() -> Bool {
        if !titleTextField.hasText || !descriptionTextField.hasText || !deadlineTextField.hasText  {
            return false
        }

        return true
    }

    @objc func handleDatePicker(sender: UIDatePicker) {
        selectedDeadline = sender.date
        dateFormatter.dateFormat = "dd MMM yyyy"
        deadlineTextField.text = dateFormatter.string(from: sender.date)
    }

    // MARK: - @IBActions

    @IBAction func createTask(_ sender: Any) {
        if fieldsAreValid() {
            let task = Task(title: titleTextField.text ?? "",
                            description: descriptionTextField.text ?? "",
                            deadline: selectedDeadline ?? Date(),
                            formattedDeadline: dateFormatter.string(from: selectedDeadline ?? Date()) ?? "",
                            isCompleted: completedSwitch.isOn)

            delegate?.didCreate(task: task)
            navigationController?.popViewController(animated: true)
        }
    }
}
