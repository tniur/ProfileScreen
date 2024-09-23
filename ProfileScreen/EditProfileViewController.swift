//
//  EditProfileViewController.swift
//  ProfileScreen
//
//  Created by Pavel Bobkov on 22.09.2024.
//

import UIKit

protocol EditProfileViewControllerDelegate: AnyObject {
    func changeProfile(_ profile: Profile)
}

final class EditProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    var profile: Profile?
    weak var delegate: EditProfileViewControllerDelegate?
    
    // MARK: - View
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let aboutInfoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "About Info"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    // MARK: - Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Methods
    
    private func setup() {
        setupUI()
        setupNavigationBar()
        setupTextFields()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let subviews = [firstNameTextField, lastNameTextField, aboutInfoTextField]
        subviews.forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 15),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            aboutInfoTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 15),
            aboutInfoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Edit Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func setupTextFields() {
        guard let profile = profile else { return }
        
        firstNameTextField.text = profile.firstName
        lastNameTextField.text = profile.lastName
        aboutInfoTextField.text = profile.aboutInfo
    }
    
    @objc private func saveButtonTapped() {
        let newProfile = Profile(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", aboutInfo: aboutInfoTextField.text ?? "")
        
        delegate?.changeProfile(newProfile)
        navigationController?.popViewController(animated: true)
    }
}
