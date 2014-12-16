//
//  helpViewController.swift
//  tapACat
//
//  Created by Bert Heinzelman on 6/12/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit
import iAd
import AVFoundation

class helpViewController: UIViewController, ADBannerViewDelegate {
    
    var adBannerView: ADBannerView = ADBannerView()
    var titleLabel = UILabel()
    var backButton = UIButton()
    let catFace = UIImageView()
    let dogFace = UIImageView()
    var audioPlayer = AVAudioPlayer()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let sizes = self.view.bounds.size
        
        //title
        self.titleLabel.frame = CGRectMake((sizes.width * 85/320), (sizes.height * 48/568), (sizes.width * 151/320), (sizes.height * 21/568))
        self.titleLabel.font = UIFont(name: "Courier", size: 22)
        self.titleLabel.text = "How To Play"
        self.titleLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(titleLabel)
        
        //back button
        self.backButton.frame = CGRectMake((sizes.width * 8/320), (sizes.height * 18/568), (sizes.width * 100/568), (sizes.height * 20/568))
        self.backButton.setTitle("Back", forState: UIControlState.Normal)
        self.backButton.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        self.backButton.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backButton)
        
        //board square 1
        let square = SquareView(frame: CGRectMake((sizes.width * 110/320), (sizes.height * 100/568), (sizes.width * 100/320), (sizes.width * 100/320)))
        self.view.addSubview(square)
        
        //cat face
        let squareSize = square.bounds.size
        catFace.frame = CGRectMake((squareSize.width * 0.25), (squareSize.height * 0.25), (squareSize.width/2), (squareSize.height/2))
        catFace.image = UIImage(named: "cartoon-cat2.png")
        catFace.alpha = 0.0
        square.addSubview(catFace)
        
        //instructions
        let instructions1 = UILabel(frame: CGRectMake((sizes.width * 10/320), (sizes.height * 210/568), (sizes.width * 310/320), (sizes.height * 25/568)))
        instructions1.text = "Tap the cat before it goes away.."
        instructions1.font = UIFont(name: "Courier New", size: 15.5)
        instructions1.textColor = UIColor.whiteColor()
        self.view.addSubview(instructions1)
        let line2 = UILabel(frame: CGRectMake((sizes.width * 90/320), (sizes.height * 240/568), (sizes.width * 140/320), (sizes.height * 25/568)))
        line2.textColor = UIColor.whiteColor()
        line2.text = "(Or you lose!)"
        line2.font = UIFont(name: "Courier New", size: 14)
        self.view.addSubview(line2)
        
        //board square 2
        let square2 = SquareView(frame: CGRectMake((sizes.width * 110/320), (sizes.height * 280/568), (sizes.width * 100/320), (sizes.width * 100/320)))
        self.view.addSubview(square2)
        
        //catface 2
        dogFace.frame = CGRectMake((squareSize.width * 0.25), (squareSize.height * 0.25), (squareSize.width/2), (squareSize.height/2))
        dogFace.image = UIImage(named:"dog.png")
        dogFace.alpha = 0.0
        square2.addSubview(dogFace)
        
        //instructions 2
        let instructions2 = UILabel(frame: CGRectMake((sizes.width * 70/320), (sizes.height * 400/568), (sizes.width * 180/320), (sizes.height * 20/568)))
        instructions2.text = "Don't tap the dogs!"
        instructions2.font = UIFont(name: "Courier New", size: 15)
        instructions2.textColor = UIColor.whiteColor()
        self.view.addSubview(instructions2)
        let line2Two = UILabel(frame: CGRectMake((sizes.width * 20/320), (sizes.height * 430/568), (sizes.width * 280/320), (sizes.height * 20/568)))
        line2Two.text = "They will scare your cat away!"
        line2Two.font = UIFont(name: "Courier New", size: 15)
        line2Two.textColor = UIColor.whiteColor()
        self.view.addSubview(line2Two)
        
        
        //iad
        self.canDisplayBannerAds = true
        self.adBannerView.delegate = self
        self.adBannerView.alpha = 0.0
        self.adBannerView.frame = CGRectMake(0, (sizes.height * 518/568), (sizes.width), (sizes.height * 50/568))
        self.view.addSubview(adBannerView)
    }
    override func viewWillAppear(animated: Bool) {
        let timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "catFaceAnimate", userInfo: nil, repeats: true)
        timer.fire()
        let timer2 = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "dogFaceAnimate", userInfo: nil, repeats: true)
        timer2.fire()
    }
    
    func catFaceAnimate() {
        
        UIView.animateWithDuration(1.5, delay: 0, options: nil, animations: {self.catFace.alpha = 1.0}, completion: {finished in (UIView.animateWithDuration(1.5, delay: 0, options: nil, animations: {self.catFace.alpha = 0}, completion:nil))})
    }
    
    func dogFaceAnimate() {
        
        UIView.animateWithDuration(1.5, delay: 0, options: nil, animations: {self.dogFace.alpha = 1.0}, completion: {finished in (UIView.animateWithDuration(1.5, delay: 0, options: nil, animations: {self.dogFace.alpha = 0}, completion:nil))})
    }

    
    func backButtonPressed() {
        buttonSound()
        let intro = introView(nibName: "introViewController", bundle: nil)
        self.presentViewController(intro, animated: true, completion: nil)
    }
    
    func buttonSound() {
        let  mainBundle = NSBundle.mainBundle()
        let filePath:String = mainBundle.pathForResource("button", ofType: "wav")!
        let fileData:NSData = NSData.dataWithContentsOfFile(filePath, options: nil, error: nil)
        self.audioPlayer = AVAudioPlayer(data: fileData, error: nil)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
