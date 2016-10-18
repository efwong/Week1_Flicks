//
//  MovieListViewController.swift
//  Week1_Flicks
//
//  Created by Edwin Wong on 10/14/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit
import AFNetworking

import NVActivityIndicatorView

class MovieListViewController: BaseMovieViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    var movieEnum: MovieEnum?
    var movies: [Movie] = []
    var currentPage: Int = 1
    var totalPages: Int = 1
    
    // for infinite scroll
    var isMoreDataLoading: Bool = false // lock access to api service to one call at a time
    var loadingView: NVActivityIndicatorView? = nil // loading indicator view
    
    @IBOutlet weak var networkErrorLabel: UILabel!
    @IBOutlet weak var movieTable: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        if MovieApiService.service.hasNetworkError{
            super.toggleNetworkError(self.networkErrorLabel, turnOn: true)
        }else{
            super.toggleNetworkError(self.networkErrorLabel, turnOn: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set title
        if self.movieEnum != nil{
            if self.movieEnum == MovieEnum.nowPlaying{
                self.title = "Now Playing"
            }else{
                self.title = "Top Rated"
            }
        }
        
        self.isMoreDataLoading = true
        // show loading UI blocker
        super.showUILoadingBlocker()
        
        // preload movie data
        self.makeMovieApiMovieListRequest(page: self.currentPage){
            () in
            self.stopAnimating() // stop animation of UILoadingBlocker
        }

        movieTable.dataSource = self
        movieTable.delegate = self
        movieTable.rowHeight = 200;
        // Do any additional setup after loading the view.
        
        // add footer to table view for infinite scroll
        self.loadingView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: NVActivityIndicatorType.ballBeat, color: UIColor.black)
        self.movieTable.tableFooterView = loadingView
        
        // add refresh control
        
        // Initialize UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: UIControlEvents.valueChanged)
        
        self.movieTable.insertSubview(refreshControl, at: 0)
        
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
                Helper.loadImageHelper(imageView: cell.moviePoster, imageUrl: movieItemImagePath)
            }else{
                cell.moviePoster.image = UIImage(named: "default_image")
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
                
                // indicate infinite scroll is fetching more data
                self.loadingView?.startAnimating()
                self.makeMovieApiMovieListRequest(page: self.currentPage+1){
                    () in
                    self.loadingView?.stopAnimating() // stop infinite scroll loading view animation
                }
//                MovieApiService.service.loadMovies(page: currentPage+1, byMovieEnum: movieEnum!){
//                    (inputMovies: [Movie]?, possibleCurrentPage: Int, possibleTotalPages:Int, success: Bool) in
//                    
//                    if success{
//                        super.toggleNetworkError(self.networkErrorLabel, turnOn: false)
//                        self.isMoreDataLoading = false
//                        self.currentPage = possibleCurrentPage
//                        self.totalPages = possibleTotalPages
//                        if inputMovies != nil{
//                            self.movies.append(contentsOf: inputMovies!)
//                        }
//                        self.movieTable.reloadData()
//                    }else{
//                        super.toggleNetworkError(self.networkErrorLabel, turnOn: true)
//                    }
//                    self.loadingView?.stopAnimating()
//                }
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
    
    // Fetch all list of movies at given page number and movie type (Now Playing vs Top Rated)
    private func makeMovieApiMovieListRequest(page: Int, completion: @escaping ()->Void){
        MovieApiService.service.loadMovies(page: page, byMovieEnum: self.movieEnum!){
            (inputMovies: [Movie]?, possibleCurrentPage: Int, possibleTotalPages:Int, success: Bool) in
            
            if success{
                super.toggleNetworkError(self.networkErrorLabel, turnOn: false)
                self.isMoreDataLoading = false
                self.currentPage = possibleCurrentPage
                self.totalPages = possibleTotalPages
                if inputMovies != nil{
                    self.movies.append(contentsOf: inputMovies!)
                }
                self.movieTable.reloadData()
            }else{
                super.toggleNetworkError(self.networkErrorLabel, turnOn: true)
            }
            completion()
        }
    }
    
    // execute on refresh control pull down
    func refreshControlAction(refreshControl: UIRefreshControl){
        self.movies.removeAll()
        self.currentPage = 1
        self.makeMovieApiMovieListRequest(page: self.currentPage){
            () in
            refreshControl.endRefreshing()
        }
    }
    
    

}
