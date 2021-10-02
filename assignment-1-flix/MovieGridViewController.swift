//
//  MovieGridViewController.swift
//  assignment-1-flix
//
//  Created by Aramis on 10/2/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var movies: [[String: Any]] = []
    @IBOutlet weak var movieGrid: UICollectionView!
    
    
    override func viewDidLoad() {
//        movieGrid.register(MovieGridCollectionViewCell.self, forCellWithReuseIdentifier: "MovieGridCell")
        movieGrid.delegate = self
        movieGrid.dataSource = self
        super.viewDidLoad()
        
        // Start the movie request
        let requestURL = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: requestURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String: Any]]
                self.movieGrid.reloadData()
            }
        }
        
        let layout = movieGrid.collectionViewLayout as? UICollectionViewFlowLayout
        let nCols = 3.0
        let colSpacing = 5.0
        let rowSpacing = colSpacing
        layout?.minimumLineSpacing = rowSpacing
        layout?.minimumInteritemSpacing = colSpacing
        let width: Double = ((view.frame.size.width - (nCols + 1) * colSpacing) / Double(nCols))
        let height: Double = width * 1.5
        layout?.itemSize = CGSize(width: width, height: height)
        layout?.sectionInset = UIEdgeInsets(top: rowSpacing, left: colSpacing, bottom: rowSpacing, right: colSpacing)
        
        
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? MovieDetailsViewController {
            let sendingCell = sender as! MovieGridCollectionViewCell
            target.movie = sendingCell.movieData
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCollectionViewCell
        
        newCell.movieData = movies[indexPath.item]

            let posterImageBasePath = "https://image.tmdb.org/t/p/w185"
            if let posterImageExtension = movies[indexPath.item]["poster_path"] as? String {
                let posterURL = URL(string: posterImageBasePath + posterImageExtension)!
                newCell.posterImage.af.setImage(withURL: posterURL)
            }

        return newCell
    }
}
