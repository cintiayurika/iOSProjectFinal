//
//  TableViewController.swift
//  TestAPIAPP
//
//  Created by Srinivasan Rao Sadanand on 4/22/18.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//

import UIKit
var trendingShows: [TrendingModel] = []
var trendingShowsFromOMBDB: [OMDBShow] = []
var myIndex = 0
class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getTrendingShows()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

/*    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    } */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trendingShowsFromOMBDB.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellShow", for: indexPath) as! TrendShowTableViewCell

        // Configure the cell...
        let show = trendingShowsFromOMBDB[indexPath.row]
        cell.showTitle?.text = show.title
        print("\(show.poster)")
        let url = URL(string: show.poster)
        let data = try? Data(contentsOf: url!)
        cell.poster?.image  = UIImage(data: data!)
        cell.poster?.clipsToBounds = true
        cell.showYear?.text = show.year
        return cell
    }
    
    func getTrendingShows(){
        let url = URL(string: "https://api.trakt.tv/shows/trending")!
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
                    trendingShows = try JSONDecoder().decode([TrendingModel].self, from: data)
                    //   print(tripsData)
                    
                    for trendingShow in trendingShows {
                        
                        //print("\((store.movie?.ids.imdb)!)")
                        let urlString = "http://www.omdbapi.com/?apikey=2f3cf8d0&i=" + (trendingShow.show?.ids.imdb)!
                        print (urlString)
                        guard let url = URL(string: urlString) else { return }
                        
                        URLSession.shared.dataTask(with: url) { (data, response, error) in
                            
                            if error != nil {
                                //print(error!.localizedDescription)
                            }
                            
                            guard let data = data else { return }
                            //Implement JSON decoding and parsing
                            do {
                                var omdbModelshow = try JSONDecoder().decode(OMDBShow.self, from: data)
     
                                trendingShowsFromOMBDB.append(omdbModelshow)

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
