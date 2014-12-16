//
//  HighScoreViewController.swift
//  tapACat
//
//  Created by Bert Heinzelman on 6/27/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit
import iAd

class HighScoreViewController: UIViewController, ADBannerViewDelegate{
    
    @IBOutlet var highScoreLabel:UILabel
    @IBOutlet var one:UILabel
    @IBOutlet var two:UILabel
    @IBOutlet var three:UILabel
    @IBOutlet var four:UILabel
    @IBOutlet var five:UILabel
    @IBOutlet var six:UILabel
    @IBOutlet var seven:UILabel
    @IBOutlet var eight:UILabel
    @IBOutlet var nine:UILabel
    @IBOutlet var ten:UILabel
    @IBOutlet var adBannerView:ADBannerView
    var bannerLoaded:Bool = false
    let rawHighScores:NameScoreStore
    var orderedHighScores:[NameScoreItem]
    
    
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.rawHighScores = NameScoreStore()
        self.orderedHighScores = [NameScoreItem]()

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @IBAction func backButtonPressed(sender : AnyObject) {
        let introViewController = introView(nibName: "introViewController", bundle: nil)
        self.presentViewController(introViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let highScoreView = HighScoreView()
        self.view!.addSubview(highScoreView)
        self.loadArray()
        self.addHighScores()
        self.canDisplayBannerAds = true
        self.adBannerView.delegate = self
        self.adBannerView.alpha = 0.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func loadArray() {
        //load temp array
        var i = 0
        var tempArray = [NameScoreItem]()
        while (i < rawHighScores.count()) {
            tempArray += rawHighScores.getItemAtIndex(CInt(i))
            i++
        }
        
        i = 0
        var count = tempArray.count
        while (i < count) {
            var index = findLeast(tempArray)
            orderedHighScores.append(tempArray[index])
            tempArray.removeAtIndex(index)
            i++
        }
        
    }
    
    func findLeast(origArray:[NameScoreItem])->Int {
        var i = 0
        var index = 0
        var least = origArray[0]
        while (i < origArray.count) {
            var x:NameScoreItem = origArray[i]
            if (least.getScore() > x.getScore()) {
                least = x
                index = i
            }
            i++
        }
        return index
    }
    
    func addHighScores() {
        var numberOfScores:Int = self.orderedHighScores.count
        let xName:CGFloat = 40.0
        let xScore:CGFloat = 200.0
        var y:CGFloat = 108.0
        
        let widthName:CGFloat = 100.0
        let widthScore:CGFloat = 60
        let height:CGFloat = 20.0
        while (numberOfScores > 0) {
            var nameLabel = UILabel(frame: CGRectMake(xName, y, widthName, height))
            var scoreLabel = UILabel(frame: CGRectMake(xScore, y, widthName, height))
            var name = orderedHighScores[numberOfScores - 1].getName()
            var score = orderedHighScores[numberOfScores - 1].getScore()
            scoreLabel.textAlignment = NSTextAlignment.Right
            nameLabel.text = name
            nameLabel.font = UIFont(name: "Courier New", size: 20)
            scoreLabel.font = UIFont(name: "Courier New", size: 20)
            scoreLabel.text = String(score)
            nameLabel.textColor = UIColor.whiteColor()
            scoreLabel.textColor = UIColor.whiteColor()
            self.view!.addSubview(nameLabel)
            self.view!.addSubview(scoreLabel)
            numberOfScores--
            y += 42
        }
    }
    
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        //self.adBannerView.alpha = 0.0
        //banner.alpha = 0.0
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        NSLog("bannerViewDidLoadAd")
        bannerLoaded = true
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
