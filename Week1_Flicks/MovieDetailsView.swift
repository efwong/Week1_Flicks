//
//  MovieDetailsView.swift
//  Week1_Flicks
//
//  Created by Edwin Wong on 10/16/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {
    // MARK: Properties
    var titleLabel: UILabel!
    var dateLabel: UILabel!
    var voteAvgLabel: UILabel!
    var runTimeLabel: UILabel!
    var genresLabel: UILabel!
    var overviewLabel: UILabel!
    
    // set margins for labels inside view
    let leftMargin: Double = 10
    let topMargin: Double = 10
    let mainFontSize: Double = 16
    
    
    // MARK: INIT
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(movie: Movie, parentView: UIView, yPos: CGFloat){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let fullViewWidth:Double = Double(parentView.frame.width)-self.leftMargin*2
        let topMargin:Double = 10
        var nextYPos:Double = 0
        // load title
        nextYPos = 0 + topMargin
        
        // load title
        self.titleLabel = UILabel(frame: CGRect(x: leftMargin, y: nextYPos, width: fullViewWidth, height: 20))
        self.titleLabel.font = getFont(size: 20.0, isBold: true)
        self.titleLabel.text = movie.title
        self.titleLabel.numberOfLines = 0
        self.titleLabel.sizeToFit()
        
        // load date
        nextYPos = nextYPos + Double(self.titleLabel.frame.height) + topMargin
        self.dateLabel = UILabel(frame: CGRect(x: leftMargin, y: nextYPos, width: 200, height: 20))
        self.dateLabel.font = getFont(size: self.mainFontSize, isBold: false)
        self.dateLabel.text = movie.releaseDateFormatted
        
        
        // load vote Avg
        nextYPos = nextYPos + Double(self.dateLabel.frame.height) + topMargin
        
        // load vote symbol
        let voteAvgImgView: UIImageView = UIImageView(image: UIImage(named: "vote_avg"))
        voteAvgImgView.frame = CGRect(x: leftMargin, y: nextYPos, width: 20, height: 20)
        voteAvgImgView.contentMode = UIViewContentMode.scaleAspectFill
        
        // load vote avg #
        self.voteAvgLabel = UILabel(frame: CGRect(x: 20 + leftMargin, y: nextYPos, width: 200, height: 20))
        self.voteAvgLabel.font = getFont(size: self.mainFontSize, isBold: false)
        self.voteAvgLabel.text = movie.voteAverageFormatted
        
        
        // load runtime
        self.runTimeLabel = UILabel(frame: CGRect(x: leftMargin + 200, y: nextYPos, width: 200, height: 20))
        self.runTimeLabel.font = getFont(size: self.mainFontSize, isBold: false)
        self.runTimeLabel.text = movie.runtimeFormatted
        
        // load genres
        nextYPos = nextYPos + Double(self.runTimeLabel.frame.height) + topMargin
        self.genresLabel = UILabel(frame: CGRect(x: leftMargin, y: nextYPos, width: fullViewWidth, height: 20))
        self.genresLabel.font = getFont(size: self.mainFontSize, isBold: false)
        self.genresLabel.text = movie.genresFormatted
        self.genresLabel.numberOfLines = 0
        self.genresLabel.sizeToFit()
        
        // load overview
        nextYPos = nextYPos + Double(self.genresLabel.frame.height) + topMargin
        self.overviewLabel = UILabel(frame: CGRect(x: leftMargin, y: nextYPos, width: fullViewWidth, height: 20))
        self.overviewLabel.font = getFont(size: self.mainFontSize, isBold: false)
        self.overviewLabel.text = movie.overview
        self.overviewLabel.numberOfLines = 0
        self.overviewLabel.sizeToFit()
        
        
        // calculate height
        let height = calculateViewHeight()
        
        // update frame
        let innerScrollYPos:CGFloat = yPos// - CGFloat(height)
        self.frame = CGRect(x: 0.0, y: innerScrollYPos, width: parentView.frame.width, height: height)
        self.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.overviewLabel)
        self.addSubview(self.dateLabel)
        self.addSubview(self.genresLabel)
        self.addSubview(voteAvgImgView)
        self.addSubview(self.voteAvgLabel)
        self.addSubview(self.runTimeLabel)
    }
    
    private func calculateViewHeight() -> CGFloat{
        // Add 10 to each height to deal with top margin
        let row1Height = self.titleLabel.frame.height + 10.0
        let row2Height = self.dateLabel.frame.height + 10.0
        let row3Height = self.voteAvgLabel.frame.height + 10.0
        let row4Height = self.genresLabel.frame.height + 10.0
        let row5Height = self.overviewLabel.frame.height + 10.0
        let updatedHeight = row1Height+row2Height+row3Height+row4Height+row5Height+20.0
        return updatedHeight
    }
    
    
    // get standard fonts for movie details
    private func getFont(size: Double, isBold: Bool) -> UIFont?{
        var font = UIFont(name: "HelveticaNeue", size: CGFloat(size))
        if isBold{
            font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(size))
        }
        return font
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
