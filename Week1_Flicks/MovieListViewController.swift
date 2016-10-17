//
//  MovieListViewController.swift
//  Week1_Flicks
//
//  Created by Edwin Wong on 10/14/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit
import AFNetworking

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var movieEnum: MovieEnum?
    
    @IBOutlet weak var movieTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // preload movie data
        MovieApiService.service.loadMovies(page: 1, byMovieEnum: movieEnum!, shouldResetMovieList: true){
            () in
            self.movieTable.reloadData()
        }
        movieTable.dataSource = self
        movieTable.delegate = self
        movieTable.rowHeight = 200;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // contruct cells from MovieAPI data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.MovieCell", for: indexPath) as! MovieItemTableViewCell
            
        let movieList = MovieApiService.service.movies
        
        if movieList.count > indexPath.row{
            let movieItem = movieList[indexPath.row]
            cell.movie = movieItem
            cell.movieTitleLabel.text = movieItem.title
            cell.movieTitleLabel.numberOfLines = 0
            cell.movieOverviewLabel.text = movieItem.overview
            cell.movieOverviewLabel.numberOfLines = 0
            if let movieItemImagePath = movieItem.posterFullPath{
                cell.moviePoster.setImageWith(movieItemImagePath)
            }
        }
        
        return cell
        
        
    }
    
    // set number of rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieApiService.service.movies.count
    }
    
    // remove gray selection of rows
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ToMovieDetailSegue" {
            if let vc = segue.destination as? MovieDetailViewController,
                let cell = sender as? MovieItemTableViewCell{
                vc.movie = cell.movie
            }
        }
    }
    

}
