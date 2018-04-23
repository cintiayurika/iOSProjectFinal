//
//  DetailViewController.swift
//  TestAPIAPP
//
//  Created by Srinivasan Rao Sadanand on 4/22/18.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//

import UIKit
var detailMovies: [MoviesModel] = []
var detailMoviesFromOMBDB: [OMDBModel] = []
class DetailViewController: UIViewController {
    var website: String = ""
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moveImage: UIImageView!
    @IBOutlet weak var relDate: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var webBtn: UIButton!
    @IBAction func openWebsite(_ sender: UIButton) {
        let settingsUrl = NSURL(string:website)! as URL
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let movie = trendingMoviesFromOMBDB[myIndex]
        
        movieTitle.font = UIFont.boldSystemFont(ofSize: movieTitle.font.pointSize)
        movieTitle.text = movie.title
        let url = URL(string: movie.poster)
        let data = try? Data(contentsOf: url!)
        moveImage.image = UIImage(data: data!)
        relDate.text = movie.released
        website = movie.website
        webBtn.setTitle(website, for: .normal)
        runtime.text = movie.runtime
        country.text = movie.country
        for rate in movie.ratings {
            rating.text = rate.value
        }
        director.text = movie.director
        genre.text = movie.genre
        
        genre.lineBreakMode = NSLineBreakMode.byWordWrapping
        genre.numberOfLines = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
