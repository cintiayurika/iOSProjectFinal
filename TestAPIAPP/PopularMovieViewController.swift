//
//  PopularMovieViewController.swift
//  TestAPIAPP
//
//  Created by Srinivasan Rao Sadanand on 4/22/18.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//

import UIKit

class PopularMovieViewController: UIViewController {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moveImage: UIImageView!
    @IBOutlet weak var relDate: UILabel!
    @IBOutlet weak var overivew: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genre: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let movie = popularMoviesFromOMBDB[myIndex]
        
        movieTitle.text = movie.title
        let url = URL(string: movie.poster)
        let data = try? Data(contentsOf: url!)
        moveImage.image = UIImage(data: data!)
        relDate.text = movie.released
        overivew.text = movie.plot
        runtime.text = movie.runtime
        country.text = movie.country
        for rate in movie.ratings {
            rating.text = rate.value
        }
        genre.text = movie.genre
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
