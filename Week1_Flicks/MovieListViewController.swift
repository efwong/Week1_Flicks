//
//  MovieListViewController.swift
//  Week1_Flicks
//
//  Created by Edwin Wong on 10/14/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit
import AFNetworking

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    var movieEnum: MovieEnum?
    var movies: [Movie] = []
    var currentPage: Int = 1
    var totalPages: Int = 1
    var isMoreDataLoading: Bool = false // for infinite scroll
    
    @IBOutlet weak var movieTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.isMoreDataLoading = true
        // preload movie data
        MovieApiService.service.loadMovies(page: currentPage, byMovieEnum: movieEnum!){
            (inputMovies: [Movie], possibleTotalPages:Int) in
            self.isMoreDataLoading = false
            self.totalPages = possibleTotalPages
            self.movies.append(contentsOf: inputMovies)
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
            
        let movieList = self.movies
        
        // check if the particular movieList Item indexed at row exists
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
        return self.movies.count
    }
    
    // remove gray selection of rows
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isMoreDataLoading && currentPage < totalPages {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = movieTable.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - movieTable.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && movieTable.isDragging) {
                isMoreDataLoading = true
                MovieApiService.service.loadMovies(page: currentPage, byMovieEnum: movieEnum!){
                    (inputMovies: [Movie], possibleTotalPages:Int) in
                    self.isMoreDataLoading = false
                    self.currentPage += 1
                    self.movies.append(contentsOf: inputMovies)
                    self.totalPages = possibleTotalPages
                    self.movieTable.reloadData()
                }
            }
        }
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
