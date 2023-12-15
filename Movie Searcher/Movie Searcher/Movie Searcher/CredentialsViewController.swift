import UIKit

class CredentialsViewController: UIViewController {
    
    let appModel = (UIApplication.shared.delegate as! AppDelegate).appModel
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    //@IBOutlet var welcomeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // Implement save functionality here
        if let name = nameTextField.text, let email = emailTextField.text {
            // Save the user details (name and email) here
            appModel.UserList.append(User(nameStr: name, emailStr: email))

            // Trigger the segue to UserDetailsViewController
//            performSegue(withIdentifier: "CredentialsToUserDetailsSegue", sender: self)
        }
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        //performSegue(withIdentifier: "CredentialsToNextSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CredentialsToUserDetailsSegue", let destinationVC = segue.destination as? UserDetailsViewController {
            // Pass the user details to the UserDetailsViewController
            destinationVC.users = appModel.UserList.last
        
        } else if segue.identifier == "CredentialsToNextSegue", let destinationVC = segue.destination as? ViewController {
            // Pass any data if needed
        }
    }
}
