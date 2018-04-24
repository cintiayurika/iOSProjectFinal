//
//  SearchTableViewController.swift
//  TestAPIAPP
//
//  Created by Inderbir Ghuman on 2018-04-23.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//

import UIKit

var searchMovies: [SearchModel] = []
var searchMoviesFromOMBDB: [OMDBModel] = []

class SearchTableViewController: UITableViewController {

    //@IBOutlet weak var searchTextField: UISearchBar!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchTextBox: UITextField!
    @IBOutlet weak var toggleMovieShow: UISegmentedControl!
    
    @IBAction func searchAction(_ sender: Any) {
        let searchString: String = searchTextBox.text!
        let type: String = toggleMovieShow.titleForSegment(at: toggleMovieShow.selectedSegmentIndex)!
        getTrendingMovies(query: searchString, type: type)
    }
    
    //@IBAction func searchText(_ sender: Any)
//    func searchBarSearchButtonClicked(_ searchTextField: UISearchBar){
//
//
//
//
//        //let url = URL(string: "https://api.trakt.tv/search/" + type + "?query=" + searchString)!
//        let url = URL(string: "https://api.trakt.tv/movies/trending")!
//        var request = URLRequest(url: url)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("2", forHTTPHeaderField: "trakt-api-version")
//        request.addValue("459266145b3b24793677649a8114c373e9d0a433a7967d0598cc677e34215523", forHTTPHeaderField: "trakt-api-key")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let response = response, let data = data {
//
//                do {
//                    //Decode retrived data with JSONDecoder and assing type of Article object
//                    searchMovies = try JSONDecoder().decode([TrendingModel].self, from: data)
//                    //   print(tripsData)
//
//                    for trendingMovie in searchMovies {
//
//                        //print("\((store.movie?.ids.imdb)!)")
//                        let urlString = "http://www.omdbapi.com/?apikey=2f3cf8d0&i=" + (trendingMovie.movie?.ids.imdb)!
//                        print (urlString)
//                        guard let url = URL(string: urlString) else { return }
//
//                        URLSession.shared.dataTask(with: url) { (data, response, error) in
//                            if error != nil {
//                                //print(error!.localizedDescription)
//                            }
//
//                            guard let data = data else { return }
//                            //Implement JSON decoding and parsing
//                            do {
//                                var omdbModel = try JSONDecoder().decode(OMDBModel.self, from: data)
//                                searchMoviesFromOMBDB.append(omdbModel)
//
//                                DispatchQueue.main.async {
//                                    self.tableView.reloadData()
//                                }
//                                //
//                            } catch let jsonError {
//                                print(jsonError)
//                            }
//
//                            }.resume()
//
//
//                    }
//
//                } catch let jsonError {
//                    print(jsonError)
//                }
//
//            } else {
//                print(error ?? "Error")
//            }
//
//        }
//
//        task.resume()
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchMoviesFromOMBDB.count
    }

    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell")! as! SearchTableViewCell
        
        let movie = searchMoviesFromOMBDB[indexPath.row]
        cell.title?.text = movie.title
        print("\(movie.poster)")
        let url = URL(string: movie.poster)
        let data = try? Data(contentsOf: url!)
        cell.poster?.image  = UIImage(data: data!)
        cell.poster?.clipsToBounds = true
        cell.year?.text = movie.year
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    
    func getTrendingMovies(query: String, type: String){
        //let url = URL(string: "https://api.trakt.tv/movies/trending")!
        let url = URL(string: "https://api.trakt.tv/search/" + type + "?query=" + query)!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("2", forHTTPHeaderField: "trakt-api-version")
        request.addValue("459266145b3b24793677649a8114c373e9d0a433a7967d0598cc677e34215523", forHTTPHeaderField: "trakt-api-key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response, let data = data {
                
                do {
                    //Decode retrived data with JSONDecoder and assing type of Article object
                    searchMovies = try JSONDecoder().decode([SearchModel].self, from: data)
                    //   print(tripsData)
                    
                    for trendingMovie in searchMovies {
                        
                        //print("\((store.movie?.ids.imdb)!)")
                        var urlString = ""
                        if(type=="movie") {
                            urlString = "http://www.omdbapi.com/?apikey=2f3cf8d0&i=" + (trendingMovie.movie?.ids.imdb)!
                        }
                        else {
                            urlString = "http://www.omdbapi.com/?apikey=2f3cf8d0&i=" + (trendingMovie.show?.ids.imdb)!
                        }
                        
                        print (urlString)
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
                                searchMoviesFromOMBDB.append(omdbModel)
                                
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
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
