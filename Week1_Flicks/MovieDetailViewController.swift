//
//  MovieDetailViewController.swift
//  Week1_Flicks
//
//  Created by Edwin Wong on 10/14/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    var titleLabel: UILabel!
    var dateLabel: UILabel!
    var voteAvgLabel: UILabel!
    var runTimeLabel: UILabel!
    var genresLabel: UILabel!
    var overviewLabel: UILabel!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
   // @IBOutlet weak var scrollViewWrapper: UIView!
    
    var innerScrollView: UIView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set scroll view properties
        self.scrollView.delegate = self
        
        // set label properties
        //titleLabel.numberOfLines = 0
        //overviewLabel.numberOfLines = 0
        //genresLabel.numberOfLines = 0
        
        
        // Do any additional setup after loading the view.
        
        // preload movie background
        if self.movie != nil {
            if let movieItemImagePath = self.movie?.posterFullPath{
                self.backgroundImage.setImageWith(movieItemImagePath)
            }
        }
        // load movie with more details
        if self.movie?.id != nil{
            MovieApiService.service.loadMovieDetails(movieId: (self.movie?.id)!){
                (movieParam: Movie) in
                //self.loadMovie(movieParam)
                self.movie = movieParam
                self.loadUIElements()
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
        
//        if let movieItemImagePath = movieParam.posterFullPath{
//            self.backgroundImage.setImageWith(movieItemImagePath)
//        }
        //resetViewHeight()
        
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
    /*
    private func loadUIElements(){
        let leftMargin:Double = 10
        let topMargin:Double = 10
        var nextYPos:Double = 0
        // load title
        nextYPos = 0 + topMargin
        
        self.titleLabel = UILabel(frame: CGRect(x: leftMargin, y: nextYPos, width: 200, height: 20))
        //self.titleLabel.numberOfLines = 0
        
        // load date
        nextYPos = nextYPos + 20 + topMargin
        self.dateLabel = UILabel(frame: CGRect(x: leftMargin, y: nextYPos, width: 200, height: 20))
        
        // load vote Avg
        nextYPos = nextYPos + 20 + topMargin
        self.voteAvgLabel = UILabel(frame: CGRect(x: leftMargin, y: nextYPos, width: 200, height: 20))
        
        // load runtime
        self.runTimeLabel = UILabel(frame: CGRect(x: leftMargin + 200, y: nextYPos, width: 200, height: 20))
        
        // load genres
        nextYPos = nextYPos + 20 + topMargin
        self.genresLabel = UILabel(frame: CGRect(x: leftMargin, y: nextYPos, width: 200, height: 20))
        
        // load overview
        nextYPos = nextYPos + 20 + topMargin
        self.overviewLabel = UILabel(frame: CGRect(x: leftMargin, y: nextYPos, width: 200, height: 20))
        
        // load text properties
        if let movieParam = self.movie{
            self.loadMovieProperties(movieParam, mTitleLabel: self.titleLabel, mOverviewLabel: self.overviewLabel, mDateLabel: self.dateLabel, mGenresLabel: self.genresLabel, mVoteAvgLabel: self.voteAvgLabel, mRunTimeLabel: self.runTimeLabel)
        }
        
        // calculate height
        let height = calculateViewHeight(mTitleLabel: self.titleLabel, mOverviewLabel: self.overviewLabel, mDateLabel: self.dateLabel, mGenresLabel: self.genresLabel, mVoteAvgLabel: self.voteAvgLabel, mRunTimeLabel: self.runTimeLabel)
        
        let innerScrollYPos:CGFloat = self.scrollView.frame.height - CGFloat(height)
        self.innerScrollView = UIView(frame: CGRect(x: 0.0, y: innerScrollYPos, width: self.scrollView.frame.width, height: height))
        self.innerScrollView.backgroundColor = UIColor.white
        
        self.innerScrollView.addSubview(self.titleLabel)
        self.innerScrollView.addSubview(self.overviewLabel)
        self.innerScrollView.addSubview(self.dateLabel)
        self.innerScrollView.addSubview(self.genresLabel)
        self.innerScrollView.addSubview(self.voteAvgLabel)
        self.innerScrollView.addSubview(self.runTimeLabel)
        
        self.scrollView.addSubview(innerScrollView)
//        let row1Height = self.titleLabel.frame.height + 10
//        let row2Height = self.dateLabel.frame.height + 10
//        let row3Height = self.voteAvgLabel.frame.height + 10
//        let row4Height = self.genresLabel.frame.height + 10
//        let row5Height = self.overviewLabel.frame.height + 10
//        let initialX = self.innerScrollViewContent.frame.origin.x
//        let initialY = self.innerScrollViewContent.frame.origin.y
//        let initialWidth = self.innerScrollViewContent.frame.width
//        let updatedHeight = row1Height+row2Height+row3Height+row4Height+row5Height+50
//        self.innerScrollViewContent.frame = CGRect(x: initialX, y: initialY, width: initialWidth, height: updatedHeight)
        
    }
 */
    
//    private func calculateViewHeight(mTitleLabel: UILabel, mOverviewLabel: UILabel, mDateLabel: UILabel, mGenresLabel: UILabel, mVoteAvgLabel: UILabel, mRunTimeLabel: UILabel) -> CGFloat{
//        // Add 10 to each height to deal with top margin
//        let row1Height = titleLabel.frame.height + 10.0
//        let row2Height = dateLabel.frame.height + 10.0
//        let row3Height = voteAvgLabel.frame.height + 10.0
//        let row4Height = genresLabel.frame.height + 10.0
//        let row5Height = overviewLabel.frame.height + 10.0
//        let updatedHeight = row1Height+row2Height+row3Height+row4Height+row5Height+50.0
//        return updatedHeight
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
