//
//  ViewController.swift
//  Week1_Flicks
//
//  Created by Edwin Wong on 10/14/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController {

    @IBOutlet weak var TESTIMAGE: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieApiService.service.loadMovies(page: 1, byMovieEnum: MovieEnum.nowPlaying)
        // Do any additional setup after loading the view, typically from a nib.
        //TESTIMAGE.setImageWith(<#T##url: URL##URL#>)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

