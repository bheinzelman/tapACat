//
//  helpViewController.swift
//  tapACat
//
//  Created by Bert Heinzelman on 6/12/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit
import iAd

class helpViewController: UIViewController, ADBannerViewDelegate {
    
    @IBOutlet var label: UILabel
    @IBOutlet var backButton: UIButton
    @IBOutlet var adBannerView: ADBannerView
    
    
    @IBAction func backButtonPressed(sender : AnyObject) {
        println("The back button was pressed")
        let introViewController = introView(nibName: "introViewController", bundle: nil)
        self.presentViewController(introViewController, animated: true, completion: nil)
    }
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.canDisplayBannerAds = true
        self.adBannerView.delegate = self
        self.adBannerView.alpha = 0.0
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
