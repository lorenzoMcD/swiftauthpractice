//
//  ViewController.swift
//  CustomLoginDemo
//
//  Created by Lorenzo McDaniel on 12/14/19.
//  Copyright © 2019 Lorenzo McDaniel. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
  
    
    
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
        
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        
        // set up video in background
       setUpVideo()
        
        
   }
    func setUpElements() {
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    

    

    
   
        
        
      

        
        

    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    func setUpVideo() {
        //get the path to the resource in bundle
        //let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        //create a url from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        // create the video player item
       let item = AVPlayerItem(url:url)
      
        //create the player
        videoPlayer = AVPlayer(playerItem: item)

        // create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        
        // Adjust the size and frame
               videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
               
               view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // add it to the view and play it
               videoPlayer?.playImmediately(atRate: 0.3)
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
}

