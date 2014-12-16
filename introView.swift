//
//  introView.swift
//  tapACat
//
//  Created by Bert Heinzelman on 6/11/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit
import iAd

class introView: UIViewController, ADBannerViewDelegate{
    
    @IBOutlet var label: UILabel
    @IBOutlet var play: UIButton
    @IBOutlet var highScore: UIButton
    @IBOutlet var help: UIButton
    @IBOutlet var cat: UIImageView
    @IBOutlet var adBannerView:ADBannerView
    
    @IBAction func helpButtonPressed(sender : AnyObject){
        println("The help Button was pressed")
        let help: helpViewController = helpViewController(nibName: "helpViewController", bundle: nil)
        self.presentViewController(help, animated: true, completion: nil)
    }
    
    @IBAction func playButtonPressed(sender : AnyObject) {
        println("The play button was pressed")
        let play = playViewController(nibName: "playViewController", bundle: nil)
        self.presentViewController(play, animated: true, completion: nil)
        
    }
    
    @IBAction func highScoreButtonPressed(sender : AnyObject) {
        println("The HighScore Button was pressed")
        let highScores = HighScoreViewController(nibName: "HighScoreViewController", bundle: nil)
        self.presentViewController(highScores, animated: true, completion: nil)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    override func viewDidLoad() {
        self.canDisplayBannerAds = true
        self.adBannerView.delegate = self
        self.adBannerView.alpha = 0.0
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        //self.adBannerView.alpha = 0.0
        //banner.alpha = 0.0
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        NSLog("bannerViewDidLoadAd")
        self.adBannerView.alpha = 1.0 //now show banner as ad is loaded
        banner.alpha = 1.0
    }
    
    func bannerViewActionDidFinish(banner: ADBannerView!) {
        NSLog("bannerViewDidLoadAd")
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        NSLog("bannerViewActionShouldBegin")
        return willLeave //I do not know if that is the correct return statement
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        NSLog("bannerView")
    }


}
