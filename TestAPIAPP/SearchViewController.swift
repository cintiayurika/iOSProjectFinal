//
//  SearchViewController.swift
//  TestAPIAPP
//
//  Created by Inderbir Ghuman on 2018-04-23.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    var website: String = ""
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var relDate: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var webBtn: UIButton!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBAction func openWebsite(_ sender: Any) {
        let settingsUrl = NSURL(string:website)! as URL
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let movie = searchMoviesFromOMBDB[myIndex]
        
        movieTitle.font = UIFont.boldSystemFont(ofSize: movieTitle.font.pointSize)
        movieTitle.text = movie.title
        let url = URL(string: movie.poster)
        let data = try? Data(contentsOf: url!)
        movieImage.image = UIImage(data: data!)
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
