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
    
    
}
