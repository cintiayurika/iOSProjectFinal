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
        let movie = trendingMoviesFromOMBDB[myIndex]
        
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
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func getMovieDetail(){
        let url = URL(string: "https://api.trakt.tv/movies/tron-legacy-2010")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("2", forHTTPHeaderField: "trakt-api-version")
        request.addValue("459266145b3b24793677649a8114c373e9d0a433a7967d0598cc677e34215523", forHTTPHeaderField: "trakt-api-key")
        
        // var trendingMovies: [TrendingModel] = [TrendingModel]()
        //   var image : String?
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response, let data = data {
                
                do {
                    //Decode retrived data with JSONDecoder and assing type of Article object
                    detailMovies = try JSONDecoder().decode([MoviesModel].self, from: data)
                    //   print(tripsData)
                    
                    for detailMovie in detailMovies {
                        print(detailMovie.title)
                        //print("\((store.movie?.ids.imdb)!)")
                        let urlString = "http://www.omdbapi.com/?apikey=2f3cf8d0&i=" + (detailMovie.ids.imdb)!
                        // print (urlString)
                        guard let url = URL(string: urlString) else { return }
                        
                        URLSession.shared.dataTask(with: url) { (data, response, error) in
                            if error != nil {
                                //print(error!.localizedDescription)
                            }
                            
                            guard let data = data else { return }
                            //Implement JSON decoding and parsing
                            do {
                                var omdbModel = try JSONDecoder().decode(OMDBModel.self, from: data)
                                //                            image = omdbModel.poster
                                detailMoviesFromOMBDB.append(omdbModel)
                                //  print(trendingMoviesFromOMBDB)
                                for detailMovie in detailMoviesFromOMBDB {
                                    print("\((detailMovie.title))")
                                    print("\((detailMovie.poster))")
                                    print("\((detailMovie.runtime))")
                                }
                                //print (trendingMoviesFromOMBDB)
                                //                        //Get back to the main queue
                          /*      DispatchQueue.main.async {
                                    
                                    self.tableView.reloadData()
                                } */
                                //
                            } catch let jsonError {
                                print(jsonError)
                            }
                            
                            }.resume()
                        
                        
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
            } else {
                print(error ?? "Error")
            }
            
        }
        
        task.resume()
        
        
    } */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
