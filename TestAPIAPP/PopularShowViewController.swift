//
//  PopularShowViewController.swift
//  TestAPIAPP
//
//  Created by Simizu Yorinori Cintia Y. on 4/22/18.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//

import UIKit

class PopularShowViewController: UIViewController {
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var relDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var language: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let show = popularShowsFromOMBDB[myIndex]
        
        showTitle.text = show.title
        let url = URL(string: show.poster)
        let data = try? Data(contentsOf: url!)
        showImage.image = UIImage(data: data!)
        relDate.text = show.released
        overview.text = show.totalSeasons
        runtime.text = show.runtime
        country.text = show.country

        for rate in show.ratings {
            rating.text = rate.value
        }
        
        genre.text = show.genre
        genre.contentMode = .scaleToFill
        genre.numberOfLines = 0
        language.text = show.language
        
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
