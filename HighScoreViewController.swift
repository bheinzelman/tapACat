//
//  HighScoreViewController.swift
//  tapACat
//
//  Created by Bert Heinzelman on 6/27/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit
import iAd
import AVFoundation


class HighScoreViewController: UIViewController, ADBannerViewDelegate,UITableViewDelegate,  UITableViewDataSource{
    
    var highScoreLabel:UILabel = UILabel()
    var backButton:UIButton = UIButton()
    var adBannerView:ADBannerView
    var bannerLoaded:Bool = false
    let rawHighScores:NameScoreStore
    var orderedHighScores:[NameScoreItem]
    var acheivements = [CompletedItem]()
    var hsTableView = UITableView()
    var aTableView = UITableView()
    //buttons
    var highScoresPresented = true
    var achievementsPresented = false
    let hsButton = UIButton()
    var acButton = UIButton()
    let grape = UIColor(red: (113/255), green: (67/255), blue: ((225/255)), alpha: 1.0)
    let footer = UIView()
    
    var audioPlayer = AVAudioPlayer()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.rawHighScores = NameScoreStore()
        self.orderedHighScores = [NameScoreItem]()
        self.adBannerView = ADBannerView()

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func backButtonPressed() {
        buttonSound()
        let introViewController = introView(nibName: "introViewController", bundle: nil)
        self.presentViewController(introViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadArray()
        //self.addHighScores()
        
        //grid
        let frame = self.view.bounds.size
        let y = (self.view.bounds.height * 0.14375)
        let height:CGFloat = ((frame.height - y) - frame.height * (50/568))
        
        
        //back button
        backButton.frame = CGRectMake((frame.width * (10/320)), (frame.height * (20/568)), (frame.width * (45/320)), (frame.height * (23/568)))
        backButton.setTitle("Back", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        self.view.addSubview(backButton)
        backButton.addTarget(self, action: "backButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        //highscorelabel
        highScoreLabel.frame = CGRectMake((frame.width * (10/320)), (frame.height * (45/568)), (frame.width * (310/320)), (frame.height * (28/568)))
        highScoreLabel.text = "HighScores & Achievements"
        highScoreLabel.font = UIFont(name: "Courier", size: 20)
        highScoreLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(highScoreLabel)
        
        //ad banner
        self.adBannerView.frame = CGRectMake(0, (frame.height - 50), frame.width, 50)
        self.view.addSubview(adBannerView)
        self.canDisplayBannerAds = true
        self.adBannerView.delegate = self
        self.adBannerView.alpha = 0.0
        
        //hstable view
        self.hsTableView.frame = CGRectMake(0, y, frame.width, height)
        hsTableView.dataSource = self
        hsTableView.delegate = self
        hsTableView.backgroundView = nil
        hsTableView.separatorColor = UIColor.cyanColor()
        hsTableView.backgroundColor = UIColor.cyanColor()
        hsTableView.allowsSelection = false
        let header = HeaderView(frame: CGRectMake(0, 0, frame.width, (frame.height * (50/568))))
        hsTableView.tableHeaderView = header
        self.view.addSubview(hsTableView)
        
        //atableview
        self.aTableView.frame = CGRectMake(0, y, frame.width, height)
        aTableView.separatorColor = UIColor.cyanColor()
        aTableView.backgroundColor = UIColor.cyanColor()
        aTableView.dataSource = self
        aTableView.delegate = self
        aTableView.allowsSelection = false
        self.loadAcheivements()

        
        //buttons set up
        hsButton.frame = CGRectMake((1), (1), (header.bounds.size.width)/2, header.bounds.size.height - 1)
        hsButton.backgroundColor = grape
        hsButton.setTitle("HighScores", forState: UIControlState.Normal)
        hsButton.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        hsButton.addTarget(self, action: "hsButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        header.addSubview(hsButton)
        
        acButton.frame = CGRectMake(((header.bounds.size.width)/2) + 1, 1, (header.bounds.size.width/2), header.bounds.size.height - 1)
        acButton.setTitle("Achievements", forState: UIControlState.Normal)
        acButton.setTitleColor(grape, forState: UIControlState.Normal)
        acButton.addTarget(self, action: "acButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        acButton.backgroundColor = UIColor.cyanColor()
        header.addSubview(acButton)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func loadArray() {
        //load temp array
        var i = 0
        var tempArray = [NameScoreItem]()
        while (i < Int(rawHighScores.count())) {
            tempArray.append(rawHighScores.getItemAtIndex(CInt(i)))
            i++
        }
        i = 0
        var count = tempArray.count
        var tempArray2 = [NameScoreItem]()
        while (i < count) {
            var index = findLeast(tempArray)
            tempArray2.append(tempArray[index])
            tempArray.removeAtIndex(index)
            i++
        }
        count = (tempArray2.count - 1)
        
        while (count >= 0) {
            orderedHighScores.append(tempArray2[count])
            count--
        }
    }
    
    func loadAcheivements() {
        let completed = CompletedStore()
        var i = 0
        println(completed.count())
        while (i < Int(completed.count())) {
            acheivements.append(completed.getItemAtIndex(Int32(i)))
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (highScoresPresented) {
            if (self.orderedHighScores.count == 0){
                return 1
            }
            return self.orderedHighScores.count
        }
        return self.acheivements.count
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: nil)
        if (highScoresPresented) {
            var items = orderedHighScores
            if (self.orderedHighScores.count > 0) {
                var theItem:NameScoreItem = items[indexPath.row]
                if (indexPath.row + 1 < 10) {
                    cell.textLabel!.text = "\((indexPath.row + 1)).   " + "\(theItem.getName())"
                }
                else {
                    cell.textLabel!.text = "\((indexPath.row + 1)). " + "\(theItem.getName())"
                }
                cell.detailTextLabel!.text = "\(theItem.getScore())"
            }
            else {
                cell.textLabel!.text = "No HighScores"
            }
            cell.textLabel!.textAlignment = NSTextAlignment.Left
            cell.detailTextLabel!.textAlignment = NSTextAlignment.Right
            return cell
        }
        if (achievementsPresented)
        {
            var items = acheivements
            var item = items[indexPath.row]
            cell.textLabel!.font = UIFont(name: "Helvetica Neue", size: 13)
            cell.detailTextLabel!.font = UIFont(name: "Helvetica Neue", size: 11)
            if (!item.getBOOL()) {
                cell.textLabel!.text = "❌ " + item.getTitle()
            }
            else{
                cell.textLabel!.text = "✅ " + item.getTitle()
            }
            cell.detailTextLabel!.text = item.getDescription()

        }
        return cell
            
    }
    
    func hsButtonPressed() {
        if (highScoresPresented) {
            return
        }
        buttonSound()
        let frame = self.view.bounds.size
        aTableView.removeFromSuperview()
        highScoresPresented = true
        achievementsPresented = false
        
        hsButton.backgroundColor = grape
        hsButton.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        hsButton.setTitle("HighScores", forState: UIControlState.Normal)
        hsButton.addTarget(self, action: "hsButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)

        
        acButton.backgroundColor = UIColor.cyanColor()
        acButton.setTitle("Achievements", forState: UIControlState.Normal)
        acButton.setTitleColor(grape, forState: UIControlState.Normal)
        acButton.addTarget(self, action: "acButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let header = HeaderView(frame: CGRectMake(0, 0, frame.width, (frame.height * (50/568))))
        header.addSubview(acButton)
        header.addSubview(hsButton)
        hsTableView.tableHeaderView = header

        self.view.addSubview(hsTableView)
        highScoresPresented = true
        achievementsPresented = false
    }
    
    func acButtonPressed() {
        if (achievementsPresented) {
            return
        }
        buttonSound()
        highScoresPresented = false
        achievementsPresented = true
        let frame = self.view.bounds.size
        hsTableView.removeFromSuperview()
        
        hsButton.backgroundColor = UIColor.cyanColor()
        hsButton.setTitleColor(grape, forState: UIControlState.Normal)
        hsButton.setTitle("HighScores", forState: UIControlState.Normal)
        hsButton.addTarget(self, action: "hsButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        acButton.backgroundColor = grape
        acButton.setTitle("Achievements", forState: UIControlState.Normal)
        acButton.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        acButton.addTarget(self, action: "acButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        let header = HeaderView(frame: CGRectMake(0, 0, frame.width, (frame.height * (50/568))))
        header.addSubview(acButton)
        header.addSubview(hsButton)
        aTableView.tableHeaderView = header
        aTableView.separatorColor = UIColor.cyanColor()
        self.view.addSubview(aTableView)
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
        bannerLoaded = true
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
