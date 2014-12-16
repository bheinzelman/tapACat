//
//  playViewController.swift
//  tapACat
//
//  Created by Bert Heinzelman on 6/14/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit
import iAd

class playViewController: UIViewController, ADBannerViewDelegate {
    
    @IBOutlet var adBannerView:ADBannerView
    
    //amount of cats that have appeared
    var displayCount = 0
    //score that gets incremented once per cat
    var scoreCount:Int = 0
    //score that is displayed
    var actualScore:Int = 0
    //label for "actualScore"
    var scoreLabel:UILabel = UILabel()
    //label for "Score: "
    var score:UILabel = UILabel()
    //appearing cat
    var catButton = UIButton()
    //Bool if cat is pressed while it is present
    var firstTouch = true
    //Bool if game is over
    var gameOver = false
    //timers to add and remove cats
    var timerAddCat = NSTimer()
    var timerRemoveCat = NSTimer()
    //level vars
    var level:Int = 1
    var levelLabel = UILabel()
    var levelNumberLabel = UILabel()
    //last space the cat was
    var lastSpacePicked = 0
    // dog buttons
    var dogButton1 = UIButton()
    var dogButton2 = UIButton()
    var dogButton3 = UIButton()
    var dogButton4 = UIButton()
    var dogButton5 = UIButton()
    var dogButton6 = UIButton()
    var dogButton7 = UIButton()
    var dogButton8 = UIButton()
    var dogButton9 = UIButton()
    var dogButton10 = UIButton()
    var dogButton11 = UIButton()
    //button array
    var dogButtonArray:[UIButton]
    

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        dogButtonArray = [dogButton1, dogButton2, dogButton3, dogButton4, dogButton5, dogButton6, dogButton7, dogButton8, dogButton9, dogButton10, dogButton11]
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = boardView(frame: CGRectMake(0, 0, 320, 568))
        super.view!.addSubview(view)
        self.addScoreLabel()
        self.initScoreLabel()
        self.adBannerView.delegate = self
        self.adBannerView.alpha = 0.0
        super.viewDidLoad()
        self.play()
    }
    
    func play() {
        timerRemoveCat = NSTimer.scheduledTimerWithTimeInterval(0.80, target: self, selector: "removeCat", userInfo: nil, repeats: true)
        timerAddCat = NSTimer.scheduledTimerWithTimeInterval(0.80, target: self, selector: "addCats", userInfo: nil, repeats: true)
    }
    

/*
    pre: instance of playViewController exists
    post: score number label is added
*/
    func initScoreLabel(){
        //sets up score labels for the "actualscore"
        scoreLabel = UILabel(frame: CGRectMake(125, 60, 100, 50))
        scoreLabel.font = UIFont(name: "Courier New", size: 20)
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.text = "\(actualScore)"
        self.view!.addSubview(scoreLabel)
        //add what level you are on
        levelNumberLabel.frame = CGRectMake(125, 100, 100, 20)
        levelNumberLabel.font = UIFont(name: "Courier New", size: 20)
        levelNumberLabel.textColor = UIColor.whiteColor()
        levelNumberLabel.text = "\(level)"
        self.view!.addSubview(levelNumberLabel)
    }
    
/*
    pre: instance of playViewController exists
    post: "score: " label is added, "Level: " label is added
*/
    func addScoreLabel(){
        //sets up "Score: "
        score.frame = CGRectMake(15, 60, 100, 50)
        score.text = "Score: "
        score.textColor = UIColor.whiteColor()
        score.font = UIFont(name: "Courier New", size: 20)
        self.view!.addSubview(score)
        //sets up level
        levelLabel.frame = CGRectMake(15, 100, 100, 20)
        levelLabel.font = UIFont(name: "Courier New", size: 20)
        levelLabel.textColor = UIColor.whiteColor()
        levelLabel.text = "Level: "
        self.view!.addSubview(levelLabel)
    }
    
/*
    pre: game is started
    post: if button is pressed, score is incremented, and level is incremnented
*/
    func changeScore(){
        
        if (self.firstTouch) {
            self.scoreCount++
        }
        self.actualScore++
        self.firstTouch = false
        self.incrementLevel()
        
        scoreLabel.text = "\(actualScore)"
        levelNumberLabel.text = "\(level)"
        
        self.view!.addSubview(levelNumberLabel)
        self.view!.addSubview(scoreLabel)
    }
    
/*
    pre: instance of playViewController exists
    post: cat button is presented on the board in a random space
*/
    
    func addCats(){
        //picks rand cat position
        let cat = UIImage(named: "CATFACE.png")
        let dogPicture = UIImage(named: "dog.png")
        //spaces taken array
        var spacesTaken:[Int] = []
        catButton.setImage(cat, forState: UIControlState.Normal)
        var rand = arc4random_uniform(12)
        while (Int(rand) == lastSpacePicked) {
            rand = arc4random_uniform(12)
        }
        lastSpacePicked = Int(rand)
        catButton.frame = positionOnBoard(Int(rand))
        spacesTaken += Int(rand)
        
        //if game is lost,  add timer is invalidated, endscreen is presented
        if ((scoreCount < displayCount )) {
            gameOver = true
            timerAddCat.invalidate()
            self.callEndScreen()
            return
        }
        //touch has not happened yet
        firstTouch = true
        catButton.addTarget(self, action: Selector("changeScore"), forControlEvents: UIControlEvents.TouchUpInside)
        displayCount++
        self.view!.addSubview(catButton)
        //dog calibration
        var i = 1
        for dog in dogButtonArray {
            if ( i > (level - 1)) {
                break
            }
            var rand = Int(arc4random_uniform(12))
            while (isTaken(rand, theArray: spacesTaken)) {
                rand = Int(arc4random_uniform(12))
            }
            spacesTaken += rand
            dog.frame = positionOnBoard(rand)
            dog.setImage(dogPicture, forState: UIControlState.Normal)
            self.view!.addSubview(dog)
            dog.addTarget(self, action: Selector("dogPressed"), forControlEvents: UIControlEvents.TouchUpInside)
            i++
        }
    }
    
/*
    pre: game has started
    post: cat button is removed from board
*/
    func removeCat() {
        catButton.removeFromSuperview()
        removeDogs()
    }
    
    func removeDogs() {
        var i = 1
        for dog in dogButtonArray {
            if (i > (level - 1)) {
                return
            }
            dog.removeFromSuperview()
            i++
        }
    }
    
    func positionOnBoard(space:Int)->CGRect {
        if (space == 1) {
            return CGRectMake(0, 142, 106.6, 106.5)
        }
        if (space == 2) {
            return CGRectMake(106.6, 142, 106.6, 106.5)
        }
        if (space == 3) {
            return CGRectMake(213.2, 142, 106.6, 106.5)
        }
        if (space == 4) {
            return CGRectMake(0, 248, 106.6, 106.5)
        }
        if (space == 5) {
            return CGRectMake(106.6, 248, 106.6, 106.5)
        }
        if (space == 6) {
            return CGRectMake(213.2, 248, 106.6, 106.5)
        }
        if (space == 7) {
            return CGRectMake(0, 355, 106.6, 106.5)
        }
        if (space == 8) {
            return CGRectMake(106.6, 355, 106.6, 106.5)
        }
        if (space == 9) {
            return CGRectMake(213.2, 355, 106.6, 106.5)
        }
        if (space == 10) {
            return CGRectMake(0, 460, 106.6, 106.5)
        }
        if (space == 11) {
             return CGRectMake(106.6, 460, 106.6, 106.5)
        }
        else {
            return CGRectMake(213.2, 460, 106.6, 106.5)
        }
    }
    
/*
    pre: callEndScreen is called
    post: end game controller is presented
*/
    func endScreen() {
        self.removeCat()
        let endScreen = EndGameViewController(nibName: "EndGameViewController", bundle: nil, Score: actualScore)
        self.presentViewController(endScreen, animated: true, completion: nil)
    }
/*
    pre: game is over
    post: endscreen is called
*/
    func callEndScreen() {
        var timerPresentEnd = NSTimer()
        if (!(displayCount < 1)) {
            self.hideScoreAddGameOver()
            timerPresentEnd = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "endScreen", userInfo: nil, repeats: false)
        }
    }
/*
    pre: changeScore() is called
    post: if actual score is divisable by 25 the level is incremented
*/
    func incrementLevel() {
        if (actualScore % 25 == 0) {
            level++
        }
    }
//func to determine if space has already been taken
    func isTaken(space: Int, theArray: [Int]) -> Bool {
        var i = 0
        for x in theArray {
            if(x == space) {
                return true
            }
        }
        return false
    }
    
    func dogPressed() {
        removeDogs()
        removeCat()
        callEndScreen()
    }
    
/*
    pre: game is over
    post: score labels are removed and GAMEOVER is presented
*/
    func hideScoreAddGameOver() {
        self.score.removeFromSuperview()
        self.scoreLabel.removeFromSuperview()
        var gameOverLabel = UILabel(frame: CGRectMake(91, 53, 140, 26))
        gameOverLabel.text = "GAMEOVER"
        gameOverLabel.font = UIFont(name: "Courier New", size: 27)
        gameOverLabel.textColor = UIColor.yellowColor()
        self.view!.addSubview(gameOverLabel)
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
