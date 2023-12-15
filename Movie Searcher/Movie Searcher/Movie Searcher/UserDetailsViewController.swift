//
//  UserDetailsViewController.swift
//  Movie Searcher
//
//  Created by user235625 on 12/14/23.
//

import UIKit

class UserDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let appModel = (UIApplication.shared.delegate as! AppDelegate).appModel
    @IBOutlet var tableView: UITableView!

    var users: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData() // Reload the table view with the updated UserList
    }

    // Implement necessary UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appModel.UserList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let user = appModel.UserList[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }

    // Implement any other necessary methods or actions here
}

    // Implement any other necessary methods or actions here

//    // Add a method to update the user data in the table view
//    func updateUserList(_ newUser: User) {
//        users.append(newUser)
//        tableView.reloadData()
//    }

