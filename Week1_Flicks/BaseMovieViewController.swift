//
//  BaseMovieViewController.swift
//  Week1_Flicks
//
//  Created by Edwin Wong on 10/17/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseMovieViewController: UIViewController, NVActivityIndicatorViewable {

    //@IBOutlet weak var errorLabel: UILabel!
    
    //var hasNetworkError: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Show UIBlocker when waiting for network
    func showUILoadingBlocker(){
        self.startAnimating(CGSize(width: 100, height: 100), message: "Loading...", type: NVActivityIndicatorType.ballGridPulse, color: UIColor.white, minimumDisplayTime: 500)
    }
    
    // turnOn : true-> shows error
    //          false-> hides error
    func toggleNetworkError(_ errorLabel:UILabel, turnOn:Bool ){
        if turnOn{
            errorLabel.isHidden = false
        }else{
            errorLabel.isHidden = true
        }
    }
    
//    func createErrorLabel() -> UILabel{
//        var errorLabelTemp = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 50.0))
//        errorLabelTemp.textColor = UIColor.white
//        errorLabelTemp.backgroundColor = UIColor(colorLiteralRed: 83.0, green: 83.0, blue: 83.0, alpha: 0.77)
//        errorLabelTemp.text = "Network Error"
//        return errorLabelTemp
//    }
    
}
