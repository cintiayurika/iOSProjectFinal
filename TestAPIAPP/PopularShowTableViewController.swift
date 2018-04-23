//
//  PopularShowTableViewController.swift
//  TestAPIAPP
//
//  Created by Srinivasan Rao Sadanand on 4/22/18.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//

import UIKit
var popularShows: [PopularMovieModel] = []
var popularShowsFromOMBDB: [OMDBShow] = []
class PopularShowTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getpopularShows()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularShowsFromOMBDB.count
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopShowCell")! as! PopShowTableViewCell
        
        
        let show = popularShowsFromOMBDB[indexPath.row]
        cell.showTitle?.text = show.title
        print("\(show.poster)")
        let url = URL(string: show.poster)
        let data = try? Data(contentsOf: url!)
        cell.poster?.image  = UIImage(data: data!)
        cell.poster?.clipsToBounds = true
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        
    }
    
    func getpopularShows(){
        let url = URL(string: "https://api.trakt.tv/shows/popular")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("2", forHTTPHeaderField: "trakt-api-version")
        request.addValue("459266145b3b24793677649a8114c373e9d0a433a7967d0598cc677e34215523", forHTTPHeaderField: "trakt-api-key")
        
        // var trendingMovies: [TrendingModel] = [TrendingModel]()
        //   var image : String?
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response, let data = data {
                
                do {
                    //Decode retrived data with JSONDecoder and assing type of Article object
                    popularShows = try JSONDecoder().decode([PopularMovieModel].self, from: data)
                    //   print(tripsData)
                    
                    for popularShow in popularShows {
                        
                        //print("\((store.movie?.ids.imdb)!)")
                        let urlString = "http://www.omdbapi.com/?apikey=2f3cf8d0&i=" + (popularShow.ids.imdb)
                        print (urlString)
                        guard let url = URL(string: urlString) else { return }
                        
                        URLSession.shared.dataTask(with: url) { (data, response, error) in
                            if error != nil {
                                //print(error!.localizedDescription)
                            }
                            
                            guard let data = data else { return }
                            //Implement JSON decoding and parsing
                            do {
                                var omdbModel = try JSONDecoder().decode(OMDBShow.self, from: data)
                                //                            image = omdbModel.poster
                                popularShowsFromOMBDB.append(omdbModel)
                                //  print(trendingMoviesFromOMBDB)
                                for popularShow in popularShowsFromOMBDB {
                                    print("\((popularShow.title))")
                                    print("\((popularShow.poster))")
                                    print("\((popularShow.runtime))")
                                }
                                //print (trendingMoviesFromOMBDB)
                                //                        //Get back to the main queue
                                DispatchQueue.main.async {
                                    
                                    self.tableView.reloadData()
                                }
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
        
        
        
    }
}
