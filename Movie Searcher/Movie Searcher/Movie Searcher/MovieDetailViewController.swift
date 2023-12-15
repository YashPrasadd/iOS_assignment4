import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var detailsTextView: UITextView!

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        if let movie = movie {
            titleLabel.text = movie.Title
            yearLabel.text = movie.Year

            // Fetch detailed movie information using OMDB API
            fetchMovieDetails(imdbID: movie.imdbID)

            // Load the image asynchronously using a library like SDWebImage.
            if let imageUrl = URL(string: movie.Poster) {
                movieImageView.sd_setImage(with: imageUrl, completed: nil)
            }
        }
    }

    func fetchMovieDetails(imdbID: String) {
        let apiURL = "https://www.omdbapi.com/?apikey=5bcc3d61&i=\(imdbID)"

        URLSession.shared.dataTask(with: URL(string: apiURL)!) { data, response, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                        let movieDetails = try JSONDecoder().decode(Movie.self, from: data)
                        DispatchQueue.main.async {
                            // Check if Plot is not nil before displaying
                            if let plot = movieDetails.Plot {
                                self.detailsTextView.text = "Plot: \(plot)"
                            } else {
                                // Handle case when Plot is nil
                                self.detailsTextView.text = "Plot not available."
                            }
                        }
                    } catch {
                        print("Error decoding movie details: \(error.localizedDescription)")
                    }
                }.resume()
            }
}
