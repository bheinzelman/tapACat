//
//  playViewController.swift
//  tapACat
//
//  Created by Bert Heinzelman on 6/14/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit
import iAd
import AudioToolbox
import AVFoundation

class playViewController: UIViewController {
    
    //cat String
    var catPictureString:String
    //amount of cats that have appeared
    var displayCount = -1
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
    var speed:NSTimeInterval = 1.1
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
    // "LEVEL UP"
    var levelUpLabel = UILabel()
    //"Speed Up"
    var speedUpLabel = UILabel()
    var acheivementEarned = false
    var audioPlayer = AVAudioPlayer()
    var dogTapped = false


    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, picture: String) {
        dogButtonArray = [dogButton1, dogButton2, dogButton3, dogButton4, dogButton5, dogButton6, dogButton7, dogButton8, dogButton9, dogButton10, dogButton11]
        catPictureString = picture
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sizes = self.view.bounds.size
        let view = boardView(frame: CGRectMake(0, (sizes.height * (142/568)),sizes.width, (sizes.height * (426/568))))
        super.view.addSubview(view)
        
    
        //sets up "Score: "
        score.frame = CGRectMake((sizes.width * (15/320)), (sizes.height * (60/568)), (sizes.width * (100/320)), (sizes.height * (18/568)))
        score.text = "Score: "
        score.textColor = UIColor.whiteColor()
        score.font = UIFont(name: "Courier New", size: 20)
        self.view.addSubview(score)
        //sets up level
        levelLabel.frame = CGRectMake((sizes.width * (15/320)), (sizes.height * (100/568)), (sizes.width * (100/320)), (sizes.height * (18/568)))
        levelLabel.font = UIFont(name: "Courier New", size: 20)
        levelLabel.textColor = UIColor.whiteColor()
        levelLabel.text = "Level: "
        self.view.addSubview(levelLabel)
        
        //sets up score labels for the "actualscore"
        scoreLabel = UILabel(frame: CGRectMake((sizes.width * (125/320)), (sizes.height * (60/568)), (sizes.width * (100/320)), (sizes.height * (23/568))))
        scoreLabel.font = UIFont(name: "Courier New", size: 20)
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.text = "\(actualScore)"
        self.view.addSubview(scoreLabel)
        //add what level you are on
        levelNumberLabel.frame = CGRectMake((sizes.width * (125/320)), (sizes.height * (100/568)), (sizes.width * (100/320)), (sizes.height*(21/568)))
        levelNumberLabel.font = UIFont(name: "Courier New", size: 20)
        levelNumberLabel.textColor = UIColor.whiteColor()
        levelNumberLabel.text = "\(level)"
        self.view.addSubview(levelNumberLabel)

        super.viewDidLoad()
        let  mainBundle = NSBundle.mainBundle()
        let filePath:String = mainBundle.pathForResource("CatMeow", ofType: "mp3")!
        let fileData:NSData = NSData.dataWithContentsOfFile(filePath, options: nil, error: nil)
        self.audioPlayer = AVAudioPlayer(data: fileData, error: nil)
        
        self.play(speed)
    }
    
    func play(speed: NSTimeInterval) {
        timerRemoveCat = NSTimer.scheduledTimerWithTimeInterval(speed, target: self, selector: "removeCat", userInfo: nil, repeats: true)
        timerAddCat = NSTimer.scheduledTimerWithTimeInterval(speed, target: self, selector: "addCats", userInfo: nil, repeats: true)
    }
    
    func meowSound() {
        let  mainBundle = NSBundle.mainBundle()
        let filePath:String = mainBundle.pathForResource("CatMeow", ofType: "mp3")!
        let fileData:NSData = NSData.dataWithContentsOfFile(filePath, options: nil, error: nil)
        self.audioPlayer = AVAudioPlayer(data: fileData, error: nil)
        audioPlayer.volume = 0.2
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func barkSound() {
        let  mainBundle = NSBundle.mainBundle()
        let filePath:String = mainBundle.pathForResource("dogBark", ofType: "wav")!
        let fileData:NSData = NSData.dataWithContentsOfFile(filePath, options: nil, error: nil)
        self.audioPlayer = AVAudioPlayer(data: fileData, error: nil)
        audioPlayer.volume = 0.2
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func madCatSound() {
        if (!dogTapped) {
            let  mainBundle = NSBundle.mainBundle()
            let filePath:String = mainBundle.pathForResource("madCat", ofType: "mp3")!
            let fileData:NSData = NSData.dataWithContentsOfFile(filePath, options: nil, error: nil)
            self.audioPlayer = AVAudioPlayer(data: fileData, error: nil)
            audioPlayer.volume = 0.05
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
    }
    
    
/*
    pre: game is started
    post: if button is pressed, score is incremented, and level is incremnented
*/
    func changeScore(){
        if (self.firstTouch || actualScore % 50 == 0) {
            self.scoreCount++
            self.meowSound()
        }
        self.actualScore++
        self.incrementLevel()
        
       
        self.firstTouch = false
        
        scoreLabel.text = "\(actualScore)"
        levelNumberLabel.text = "\(level)"
        
        self.view.addSubview(levelNumberLabel)
        self.view.addSubview(scoreLabel)
        self.checkScoreAchievements()
        self.checkLevelAchievement()
    }
    
/*
    pre: instance of playViewController exists
    post: cat button is presented on the board in a random space
*/
    
    func addCats(){
        displayCount++
        //picks rand cat position
        let cat = UIImage(named: catPictureString)
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
        spacesTaken.append(Int(rand))
        
        //if game is lost,  add timer is invalidated, endscreen is presented
        if ((scoreCount < displayCount)) {
            gameOver = true
            timerAddCat.invalidate()
            madCatSound()
            self.callEndScreen()
            return
        }
        //touch has not happened yet
        firstTouch = true
        catButton.addTarget(self, action: Selector("changeScore"), forControlEvents: UIControlEvents.TouchUpInside)
        catButton.alpha = 0.0
        self.view.addSubview(catButton)
        

        UIView.animateWithDuration(0.3, animations: {self.catButton.alpha = 1.0})
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
            spacesTaken.append(Int(rand))
            dog.frame = positionOnBoard(rand)
            dog.setImage(dogPicture, forState: UIControlState.Normal)
            dog.alpha = 0.0
            self.view.addSubview(dog)
            UIView.animateWithDuration(0.3, animations: {dog.alpha = 1.0})
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
        let sizes = self.view.bounds.size
        let x1:CGFloat = (0.0)
        let x2:CGFloat = (sizes.width * (106.6/320))
        let x3:CGFloat = (sizes.width * (213.2/320))
        let y1:CGFloat = (sizes.height * (146/568))
        let y2:CGFloat = (sizes.height * (254/568))
        let y3:CGFloat = (sizes.height * (359/568))
        let y4:CGFloat = (sizes.height * (464/568))
        let width:CGFloat = (sizes.width * (106.6/320))
        let height:CGFloat = (sizes.height * (100.5/568))
        
        if (space == 1) {
            return CGRectMake(x1, y1, width, height)
        }
        if (space == 2) {
            return CGRectMake(x2, y1, width, height)
        }
        if (space == 3) {
            return CGRectMake(x3, y1, width, height)
        }
        if (space == 4) {
            return CGRectMake(x1, y2, width, height)
        }
        if (space == 5) {
            return CGRectMake(x2, y2, width, height)
        }
        if (space == 6) {
            return CGRectMake(x3, y2, width, height)
        }
        if (space == 7) {
            return CGRectMake(x1, y3, width, height)
        }
        if (space == 8) {
            return CGRectMake(x2, y3, width, height)
        }
        if (space == 9) {
            return CGRectMake(x3, y3, width, height)
        }
        if (space == 10) {
            return CGRectMake(x1, y4, width, height)
        }
        if (space == 11) {
            return CGRectMake(x2, y4, width, height)
        }
        else {
            return CGRectMake(x3, y4, width, height)
            
        }
    }
    
/*
    pre: callEndScreen is called
    post: end game controller is presented
*/
    func endScreen() {
        self.removeCat()
        let endScreen = EndGameViewController(nibName: "EndGameViewController", bundle: nil, Score: actualScore, acheivementEarned:acheivementEarned)
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
        if (Float(actualScore) % 25 == 0.0) {
            level++
            levelNumberLabel.textColor = UIColor.yellowColor()
            levelUp()
        }
        // kills timers and sets new ones with faster speeds
        if (Float(actualScore) % 50 == 0.0) {
            if (speed > 0.6) {
                timerRemoveCat.fire()
                timerAddCat.invalidate()
                timerRemoveCat.invalidate()
                displayCount = -1
                scoreCount = 0
                firstTouch = true

                play(speedUp())
                timerAddCat.fire()
                presentSpeedUpLabel()
                
            }
        }
        else {
            levelNumberLabel.textColor = UIColor.whiteColor()
        }
    }
    
    // chages the time interval for the add/remove cat timers
    func speedUp()->NSTimeInterval {
        if (speed == 0.6) {
            return speed
        }
        var newSpeed = speed - 0.1
        speed = newSpeed
        return speed
    }
    
    
/*
    pre: new level
    post: level up blinks 
*/
    func levelUp() {
        let sizes = self.view.bounds.size
        levelUpLabel.frame = CGRectMake((sizes.width * (175/320)), (sizes.height * (60/568)), (sizes.width * (125/320)), (sizes.height * (25/568)))
        levelUpLabel.text = "⬆️ LEVEL UP"
        levelUpLabel.font = UIFont(name: "Courier New", size: 18)
        levelUpLabel.textColor = UIColor.yellowColor()
        levelUpLabel.alpha = 0.0
        self.view.addSubview(levelUpLabel)
        UIView.animateWithDuration(1.0, delay: 0.0, options:nil, animations: {self.levelUpLabel.alpha = 1.0}, completion: {finished in UIView.animateWithDuration(1.0, delay: 0.0, options: nil, animations: {self.levelUpLabel.alpha = 0}, completion: {finished in self.levelUpLabel.removeFromSuperview()})})
    }
    
    func presentSpeedUpLabel() {
        let sizes = self.view.bounds.size
        speedUpLabel.frame = CGRectMake((sizes.width * (175/320)), (sizes.height * (100/568)), (sizes.width * (125/320)),(sizes.height * (25/568)))
        speedUpLabel.text = "⬆️ SPEEDING UP"
        speedUpLabel.font = UIFont(name: "Courier New", size: 14)
        speedUpLabel.textColor = UIColor.yellowColor()
        speedUpLabel.alpha = 0.0
        self.view.addSubview(speedUpLabel)
        UIView.animateWithDuration(1.0, delay: 0.0, options:nil, animations: {self.speedUpLabel.alpha = 1.0}, completion: {finished in UIView.animateWithDuration(1.0, delay: 0.0, options: nil, animations: {self.speedUpLabel.alpha = 0}, completion: {finished in self.speedUpLabel.removeFromSuperview()})})
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
        dogTapped = true
        barkSound()
        var stats = GameDataStore()
        stats.stats.dogTapped()
        stats.saveChanges()
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        removeDogs()
        removeCat()
        
        callEndScreen()
    }
    
    func checkScoreAchievements() {
        var completed = CompletedStore()
        if (actualScore >= 100) {
            if (!completed.getItemAtIndex(Int32(3)).getBOOL()) {
                var acheivement1 = completed.getItemAtIndex(3)
                acheivement1.setTRUE()
                completed.addItemAtIndex(Int32(3), item: acheivement1)
                acheivementEarned = true
            }
        }
        if (actualScore >= 250) {
            if (!completed.getItemAtIndex(Int32(4)).getBOOL()) {
                var acheivement2 = completed.getItemAtIndex(Int32(4))
                acheivement2.setTRUE()
                completed.addItemAtIndex(Int32(4), item: acheivement2)
                acheivementEarned = true
            }
        }
        if (actualScore >= 500) {
            if (!completed.getItemAtIndex(Int32(5)).getBOOL()) {
                var acheivement3 = completed.getItemAtIndex(Int32(5))
                acheivement3.setTRUE()
                completed.addItemAtIndex(Int32(5), item: acheivement3)
                acheivementEarned = true
            }
        }
        if (actualScore >= 750) {
            if (!completed.getItemAtIndex(Int32(6)).getBOOL()) {
                var acheivement4 = completed.getItemAtIndex(Int32(6))
                acheivement4.setTRUE()
                completed.addItemAtIndex(Int32(6), item: acheivement4)
                acheivementEarned = true
            }
        }
        completed.saveChanges()
    }
    
    func checkLevelAchievement()
    {
        var completed = CompletedStore()
        if (actualScore >= 100) {
            if (!completed.getItemAtIndex(Int32(0)).getBOOL()) {
                var acheivement6 = completed.getItemAtIndex(Int32(0))
                acheivement6.setTRUE()
                completed.addItemAtIndex(Int32(0), item: acheivement6)
                acheivementEarned = true
            }
        }
        if (actualScore >= 200) {
            if (!completed.getItemAtIndex(Int32(1)).getBOOL()) {
                var acheivement5 = completed.getItemAtIndex(Int32(1))
                acheivement5.setTRUE()
                completed.addItemAtIndex(Int32(1), item: acheivement5)
                acheivementEarned = true
            }
        }
        if (actualScore >= 275) {
            if (!completed.getItemAtIndex(Int32(2)).getBOOL()) {
                var acheivement7 = completed.getItemAtIndex(Int32(2))
                acheivement7.setTRUE()
                completed.addItemAtIndex(Int32(2), item: acheivement7)
                acheivementEarned = true
            }
        }
        completed.saveChanges()
    }
    
/*
    pre: game is over
    post: score labels are removed and GAMEOVER is presented
*/
    func hideScoreAddGameOver() {
        self.score.removeFromSuperview()
        self.scoreLabel.removeFromSuperview()
        self.levelNumberLabel.removeFromSuperview()
        self.levelLabel.removeFromSuperview()
        self.levelUpLabel.removeFromSuperview()
        self.speedUpLabel.removeFromSuperview()
        
        let sizes = self.view.bounds.size
        var gameOverLabel = UILabel(frame: CGRectMake((sizes.width * (91/320)),(sizes.height * (60/568)),(sizes.width * (140/320)), (sizes.height * (26/568))))
        gameOverLabel.text = "GAMEOVER"
        gameOverLabel.font = UIFont(name: "Courier", size: 27)
        gameOverLabel.textColor = UIColor.yellowColor()
        self.view.addSubview(gameOverLabel)

    }
    
}
