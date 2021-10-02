//
//  MovieDetailsViewController.swift
//  assignment-1-flix
//
//  Created by Aramis on 10/2/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageWide: UIImageView!
    @IBOutlet weak var posterImageSmall: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Start by rendering text
        titleLabel.text = movie["title"] as? String ?? ""
        descriptionLabel.text = movie["overview"] as? String ?? ""
        
        // Render images
        let posterImageBasePath = "https://image.tmdb.org/t/p/w185"
        if let posterImageExtension = movie["poster_path"] as? String {
            let posterURL = URL(string: posterImageBasePath + posterImageExtension)!
            posterImageSmall.af.setImage(withURL: posterURL)
        }
        
        let backgroundImageBasePath = "https://image.tmdb.org/t/p/w780"
        if let backgroundImageExtension = movie["backdrop_path"] as? String {
            let backgroundURL = URL(string: backgroundImageBasePath + backgroundImageExtension)!
            backgroundImageWide.af.setImage(withURL: backgroundURL)
        }
//        self.updateViewConstraints()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
