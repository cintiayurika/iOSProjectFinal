//
//  PopularMovieViewController.swift
//  TestAPIAPP
//
//  Created by Simizu Yorinori Cintia Y. on 4/22/18.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//

import UIKit

class PopularMovieViewController: UIViewController {
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

        // Do any additional setup after loading the view.
        let movie = popularMoviesFromOMBDB[myIndex]
        
        movieTitle.text = movie.title
        let url = URL(string: movie.poster)
        let data = try? Data(contentsOf: url!)
        moveImage.image = UIImage(data: data!)
        relDate.text = movie.released
        runtime.text = movie.runtime
        country.text = movie.country
        for rate in movie.ratings {
            rating.text = rate.value
        }
        genre.text = movie.genre
        genre.contentMode = .scaleToFill
        genre.numberOfLines = 0
        director.text = movie.director
        website = movie.website
        webBtn.setTitle(website, for: .normal)
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
