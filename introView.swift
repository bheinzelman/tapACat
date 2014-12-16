//
//  introView.swift
//  tapACat
//
//  Created by Bert Heinzelman on 6/11/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit
import iAd
import AVFoundation

class introView: UIViewController, ADBannerViewDelegate{
    
    var tapACat: UILabel = UILabel()
    var play: UIButton = UIButton()
    var highScore:UIButton = UIButton()
    var help: UIButton = UIButton()
    var cat: UIImageView
    var adBannerView:ADBannerView
    var audioPlayer = AVAudioPlayer()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.adBannerView = ADBannerView()
        var catFace = UIImage(named: "Tap-A-Cat(cat).png")//"CATFACE.png")
        self.cat = UIImageView(image:catFace)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        //ad banner
        adBannerView.frame = CGRectMake(0, (self.view.bounds.size.height - 50), self.view.bounds.size.width, 50)
        self.canDisplayBannerAds = true
        self.adBannerView.delegate = self
        self.adBannerView.alpha = 0.0
        
        var sizes = self.view.bounds.size
        
        //cat pic
        cat.frame = CGRectMake((sizes.width * (101/320)), (sizes.height * (371/568)) , (sizes.width * (119/320)), sizes.height * (130/568))
        self.view.addSubview(cat)
        
        //help button
        help.frame = CGRectMake((sizes.width * (95/320)), (sizes.height * (272/568)), (sizes.width * (130/320)), sizes.height/*(sizes.height * (47/568))*/)
        help.setTitle("Help", forState: UIControlState.Normal)
        help.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        self.view.addSubview(help)
        help.addTarget(self, action: "helpButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        //highscore button
        highScore.frame = CGRectMake(sizes.width/*(sizes.width * (78/320))*/, (sizes.height * (217/568)), (sizes.width * (164/320)), (sizes.height * (47/568)))
        highScore.setTitle("HighScores", forState: UIControlState.Normal)
        highScore.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        self.view.addSubview(highScore)
        highScore.addTarget(self, action: "highScoreButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        //play button
        play.frame = CGRectMake(0/*(sizes.width * (97/320))*/, (sizes.height * (164/568)), (sizes.width * (127/320)), (sizes.height * (45/568)))
        
        play.setTitle("Play!", forState: UIControlState.Normal)
        play.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        self.view.addSubview(play)
        play.addTarget(self, action: "playButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        //tapACat
        tapACat.text = "tapACat"
        tapACat.frame = CGRectMake((sizes.width * (90/320)), (sizes.height * (81/568)), (sizes.width * (151/320)), (sizes.height * (51/568)))
        tapACat.font = UIFont(name: "Courier", size: 33)
        tapACat.textColor = UIColor.whiteColor()
        self.view.addSubview(tapACat)
        tapACat.alpha = 0.0
        
        
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(animated: Bool) {
        var sizes = self.view.bounds.size
        UIView.animateWithDuration(1.0, animations: {self.tapACat.alpha = 1.0})
        UIView.animateWithDuration(1.0, animations: {self.play.frame = CGRectMake((sizes.width * (97/320)), (sizes.height * (164/568)), (sizes.width * (127/320)), (sizes.height * (45/568)))})
        UIView.animateWithDuration(1.0, animations: {self.highScore.frame = CGRectMake((sizes.width * (78/320)), (sizes.height * (217/568)), (sizes.width * (164/320)), (sizes.height * (47/568)))})
        UIView.animateWithDuration(1.0, animations: {self.help.frame = CGRectMake((sizes.width * (95/320)), (sizes.height * (272/568)), (sizes.width * (130/320)), (sizes.height * (47/568)))})

        self.view.addSubview(adBannerView)

    }
    
    
    func helpButtonPressed() {
        buttonSound()
        println("The help Button was pressed")
        let help: helpViewController = helpViewController(nibName: "helpViewController", bundle: nil)
        self.presentViewController(help, animated: true, completion: nil)
    }
    
    func playButtonPressed() {
        buttonSound()
        println("The play button was pressed")
        let catVC = CatSelectViewController(nibName: "CatSelectViewController", bundle: nil)
        self.presentViewController(catVC, animated: true, completion: nil)
        
    }
    
    func highScoreButtonPressed() {
        buttonSound()
        println("The HighScore Button was pressed")
        let highScores = HighScoreViewController(nibName: "HighScoreViewController", bundle: nil)
        self.presentViewController(highScores, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonSound() {
        let  mainBundle = NSBundle.mainBundle()
        let filePath:String = mainBundle.pathForResource("button", ofType: "wav")!
        let fileData:NSData = NSData.dataWithContentsOfFile(filePath, options: nil, error: nil)
        self.audioPlayer = AVAudioPlayer(data: fileData, error: nil)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    
    
    func bannerViewWillLoadAd(banner: ADBannerView) {
        //self.adBannerView.alpha = 0.0
        //banner.alpha = 0.0
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView) {
        NSLog("bannerViewDidLoadAd")
        self.adBannerView.alpha = 1.0 //now show banner as ad is loaded
        banner.alpha = 1.0
    }
    
    func bannerViewActionDidFinish(banner: ADBannerView) {
        NSLog("bannerViewDidLoadAd")
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView, willLeaveApplication willLeave: Bool) -> Bool {
        NSLog("bannerViewActionShouldBegin")
        return willLeave //I do not know if that is the correct return statement
    }
    
    func bannerView(banner: ADBannerView, didFailToReceiveAdWithError error: NSError) {
        NSLog("bannerView")
    }


}
