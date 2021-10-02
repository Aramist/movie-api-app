//
//  MoviesViewController.swift
//  assignment-1-flix
//
//  Created by Aramis on 9/26/21.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var movieTable: UITableView!
    
    var movieArray: [[String: Any]] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        movieTable.dataSource = self
        movieTable.delegate = self
        
        let requestURL = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: requestURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movieArray = dataDictionary["results"] as! [[String: Any]]
                self.movieTable.reloadData()
            }
        }
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = movieTable.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell {

            let movie = movieArray[indexPath.row]
            let title = movie["title"] as? String ?? ""
            let synopsis = movie["overview"] as? String ?? ""

            cell.upperLabel.text = title
            cell.lowerLabel.text = synopsis
            
//            Start adding the poster image: request the image
            let posterBaseURL = "https://image.tmdb.org/t/p/w185"
            let posterPath = movieArray[indexPath.row]["poster_path"] as? String ?? ""
            
            if posterPath != "" {
                if let posterURL = URL(string: posterBaseURL + posterPath) {
                    cell.posterImage.af.setImage(withURL: posterURL)
                }
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieCell = sender as? MovieCell {
            if let indexPath = movieTable.indexPath(for: movieCell) {
                let movie: [String: Any] = movieArray[indexPath.row]
                if let detailView = segue.destination as? MovieDetailsViewController {
                    detailView.movie = movie
                }
                movieTable.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
}

