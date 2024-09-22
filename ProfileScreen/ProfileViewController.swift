//
//  ProfileViewController.swift
//  ProfileScreen
//
//  Created by Pavel Bobkov on 22.09.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private var profile: Profile?
    
    // MARK: - View
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let aboutInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    // MARK: - Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profile = Profile(firstName: "FirstName", lastName: "LastName", aboutInfo: "About info")
        
        setup()
    }
    
    // MARK: - Methods
    
    private func setup() {
        setupUI()
        setupNavigationBar()
        
        updateProfile()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        view.addSubview(aboutInfoLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            aboutInfoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            aboutInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let changeInfoButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButton))
        navigationItem.rightBarButtonItem = changeInfoButton
    }
    
    @objc private func editButton() {
        let editProfileViewController = EditProfileViewController()
        editProfileViewController.delegate = self
        editProfileViewController.profile = profile
        
        navigationController?.pushViewController(editProfileViewController, animated: true)
    }
    
    private func updateProfile() {
        guard let profile = profile else { return }
        
        nameLabel.text = profile.firstName + " " + profile.lastName
        aboutInfoLabel.text = profile.aboutInfo
    }
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func changeProfile(_ profile: Profile) {
        self.profile = profile
        
        updateProfile()
    }
}
