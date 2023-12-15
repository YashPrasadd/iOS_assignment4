import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    @IBOutlet var field: UITextField!

    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        field.delegate = self
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }

    // MARK: - Search Movies

    func searchMovies() {
        field.resignFirstResponder()

        guard let text = field.text, !text.isEmpty else {
            return
        }

        NetworkingManager.shared.searchForMovies(searchTerm: text) { [weak self] result in
            guard let self = self else { return }

            if let movies = result?.Search {
                self.movies = movies
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }
        }
    }

    // MARK: - Table

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // Perform segue to MovieDetailViewController
        performSegue(withIdentifier: "ShowMovieDetailSegue", sender: indexPath)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieDetailSegue", let destinationVC = segue.destination as? MovieDetailViewController, let indexPath = sender as? IndexPath {
            let selectedMovie = movies[indexPath.row]
            destinationVC.movie = selectedMovie
        } else if segue.identifier == "CredentialsToNextSegue", let destinationVC = segue.destination as? CredentialsViewController {
            // Pass any data if needed
        }
    }
}
