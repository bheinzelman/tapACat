//
//  CatSelectViewController.swift
//  tapACat
//
//  Created by Bert Heinzelman on 8/18/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit
import iAd
import AVFoundation

class CatSelectViewController: UIViewController, ADBannerViewDelegate {
    var scroll = UIScrollView()
    var cat1:UIImage
    var cat2:UIImage
    var cat3:UIImage
    var adBannerView:ADBannerView = ADBannerView()
    var audioPlayer = AVAudioPlayer()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.cat1 = UIImage(named: "cartoon-cat2.png")
        self.cat2 = UIImage(named: "CATFACE.png")
        self.cat3 = UIImage(named:"Tap-A-Cat(cat).png")
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        let sizes = self.view.bounds.size
        
        var swipeLabel = UILabel(frame: CGRectMake((sizes.width * 18/320), (sizes.height * 30/568), (sizes.width * 290/320), (sizes.height * 30/568)))
        swipeLabel.text = "Swipe to select a Cat"
        swipeLabel.font = UIFont(name: "Courier", size: 22)
        swipeLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(swipeLabel)
        //scroll view set up
        scroll.frame = CGRectMake(0, (sizes.height * (100/568)), sizes.width, (sizes.height * (418/568)))
        scroll.pagingEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        self.view.addSubview(scroll)
        let bigFrame = CGRectMake(0, 0, sizes.width * 3, sizes.height)
        var content:CGSize = CGSizeMake(bigFrame.width, 1.0)
        scroll.contentSize = content

        //view set up
        var view1 = UIView(frame: CGRectMake(0, 0, bigFrame.size.width/3, bigFrame.size.height))
        view1.backgroundColor = UIColor.clearColor()
        scroll.addSubview(view1)
        var view2 = UIView(frame: CGRectMake(bigFrame.size.width/3, 0, bigFrame.size.width/3, bigFrame.size.height))
        view2.backgroundColor = UIColor.clearColor()
        var view3 = UIView(frame: CGRectMake(2*(bigFrame.size.width/3), 0, bigFrame.size.width/3, bigFrame.size.height))
        scroll.addSubview(view2)
        scroll.addSubview(view3)
        
        //button set up
        let bigSizes = bigFrame.size
        let viewSizes = view1.bounds.size
        
        var catButton1 = UIImageView(frame: CGRectMake((bigSizes.width * (48/960)), (bigSizes.height * 20/568), (bigSizes.width * 220/960), (bigSizes.height * 300/568)))
        catButton1.image = cat1
        catButton1.userInteractionEnabled = true
        view1.addSubview(catButton1)
        let tap = UITapGestureRecognizer(target: self, action: "cat1Pressed:")
        catButton1.addGestureRecognizer(tap)
        
        var cat1Label = UILabel(frame: CGRectMake((viewSizes.width * (100/320)), (viewSizes.height * 330/568), (viewSizes.width * 200/320), (viewSizes.height * 20/568)))
        cat1Label.text = "Cartoon Cat"
        cat1Label.font = UIFont(name: "Courier New", size: 18)
        cat1Label.textColor = UIColor.whiteColor()
        view1.addSubview(cat1Label)
        
        var catButton2 = UIImageView(frame: CGRectMake((bigSizes.width * (50/960)), (bigSizes.height * 70/568), (bigSizes.width * 220/960), (bigSizes.height * 200/568)))
        catButton2.image = cat2
        catButton2.userInteractionEnabled = true
        view2.addSubview(catButton2)
        let tap2 = UITapGestureRecognizer(target: self, action: "cat2Pressed:")
        catButton2.addGestureRecognizer(tap2)
        
        var cat2Label = UILabel(frame: CGRectMake((viewSizes.width * (90/320)), (viewSizes.height * 330/568), (viewSizes.width * 200/320), (viewSizes.height * 20/568)))
        cat2Label.text = "Minimalist Cat"
        cat2Label.font = UIFont(name: "Courier New", size: 18)
        cat2Label.textColor = UIColor.whiteColor()
        view2.addSubview(cat2Label)
        
        var catButton3 = UIImageView(frame: CGRectMake((bigSizes.width * (50/960)), (bigSizes.width * 20/568), ((bigSizes.width * 220/960)), (bigSizes.height * 300/568)))
        catButton3.image = cat3
        catButton3.userInteractionEnabled = true
        view3.addSubview(catButton3)
        let tap3 = UITapGestureRecognizer(target: self, action: "cat3Pressed:")
        catButton3.addGestureRecognizer(tap3)
        
        
        var cat3Label = UILabel(frame: CGRectMake((viewSizes.width * (112/320)), (viewSizes.height * 325/568), (viewSizes.width * 200/320), (viewSizes.height * 20/568)))
        cat3Label.text = "Alley Cat"
        cat3Label.font = UIFont(name: "Courier New", size: 18)
        cat3Label.textColor = UIColor.whiteColor()
        view3.addSubview(cat3Label)

        //iad
        let height = (sizes.height * (50/568))
        adBannerView.frame = CGRectMake(0, sizes.height-height, sizes.width, height)
        self.view.addSubview(adBannerView)
        self.canDisplayBannerAds = true
        self.adBannerView.delegate = self
        self.adBannerView.alpha = 0.0

    }
    
    func cat1Pressed(gesture: UITapGestureRecognizer) {
        meowSound()
        self.adBannerView.removeFromSuperview()
        let playVC = playViewController(nibName: "playViewController", bundle: nil, picture: "cartoon-cat2.png")
        self.presentViewController(playVC, animated: true, completion: nil)
    }
    
    
    func cat2Pressed(gesture: UITapGestureRecognizer) {
        meowSound()
        self.adBannerView.removeFromSuperview()
        let playVC = playViewController(nibName: "playViewController", bundle: nil, picture: "CATFACE.png")
        self.presentViewController(playVC, animated: true, completion: nil)
    }
    
    func cat3Pressed(gesture: UITapGestureRecognizer) {
        meowSound()
        self.adBannerView.removeFromSuperview()
        let playVC = playViewController(nibName: "playViewController", bundle: nil, picture: "Tap-A-Cat(cat).png")
        self.presentViewController(playVC, animated: true, completion: nil)
    }

    
    func meowSound() {
        let  mainBundle = NSBundle.mainBundle()
        let filePath:String = mainBundle.pathForResource("CatMeow", ofType: "mp3")!
        let fileData:NSData = NSData.dataWithContentsOfFile(filePath, options: nil, error: nil)
        self.audioPlayer = AVAudioPlayer(data: fileData, error: nil)
        audioPlayer.volume = 0.3
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
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        NSLog("bannerView")
    }
    


}
