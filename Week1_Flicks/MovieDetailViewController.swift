//
//  MovieDetailViewController.swift
//  Week1_Flicks
//
//  Created by Edwin Wong on 10/14/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class MovieDetailViewController: BaseMovieViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    var titleLabel: UILabel!
    var dateLabel: UILabel!
    var voteAvgLabel: UILabel!
    var runTimeLabel: UILabel!
    var genresLabel: UILabel!
    var overviewLabel: UILabel!
    
    
    @IBOutlet weak var networkErrorLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
   // @IBOutlet weak var scrollViewWrapper: UIView!
    
    var innerScrollView: UIView!
    
    var movie: Movie?
    
    override func viewWillAppear(_ animated: Bool) {
        if MovieApiService.service.hasNetworkError{
            super.toggleNetworkError(self.networkErrorLabel, turnOn: true)
        }else{
            super.toggleNetworkError(self.networkErrorLabel, turnOn: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set scroll view properties
        self.scrollView.delegate = self
        
        // Do any additional setup after loading the view.
        
        // preload movie background
        if self.movie != nil {
            if let movieItemImagePath = self.movie?.posterFullPath{
                self.backgroundImage.setImageWith(movieItemImagePath)
            }else{
                self.backgroundImage.image = UIImage(named: "default_image")
            }
        }
        // load movie with more details
        if self.movie?.id != nil{
            
            // start animation for loading screen
            super.showUILoadingBlocker()
            
            MovieApiService.service.loadMovieDetails(movieId: (self.movie?.id)!){
                (movieParam: Movie?, success: Bool) in
                if success{
                    super.toggleNetworkError(self.networkErrorLabel, turnOn: false)
                    self.movie = movieParam
                    self.loadUIElements()
                }else{
                    super.toggleNetworkError(self.networkErrorLabel, turnOn:true)
                }
                self.stopAnimating()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func loadMovieProperties(_ movieParam: Movie, mTitleLabel: UILabel, mOverviewLabel: UILabel, mDateLabel: UILabel, mGenresLabel: UILabel, mVoteAvgLabel: UILabel, mRunTimeLabel: UILabel){
        
        mTitleLabel.text = movieParam.title
        mOverviewLabel.text = movieParam.overview
        mOverviewLabel.sizeToFit()
        mDateLabel.text = movieParam.releaseDateFormatted
        mGenresLabel.text = movieParam.genresFormatted
        mGenresLabel.sizeToFit()
        mVoteAvgLabel.text = movieParam.voteAverageFormatted
        mRunTimeLabel.text = movieParam.runtimeFormatted
        
    }
    
    private func loadUIElements(){
        if let movieParam = self.movie{
            // update scroll view
            let ypos: CGFloat = CGFloat(400)
            let movieDetailsView = MovieDetailsView(movie: movieParam, parentView: self.scrollView, yPos: ypos)
            
            let contentWidth = scrollView.bounds.width
            let contentHeightIncrement = movieDetailsView.bounds.height - (scrollView.bounds.height - CGFloat(ypos))
            let contentHeight = (contentHeightIncrement > 0) ? scrollView.bounds.height + contentHeightIncrement + 20 : scrollView.bounds.height
                //scrollView.bounds.height + (400-movieDetailsView.bounds.height)
            self.scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
            self.scrollView.addSubview(movieDetailsView)
        }
    }
    
}
