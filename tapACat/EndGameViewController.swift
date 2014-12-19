//
//  EndGameViewController.swift
//  tapACat
//
//  Created by Bert Heinzelman on 6/21/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit
import iAd
import AVFoundation

class EndGameViewController: UIViewController, ADBannerViewDelegate, UITextFieldDelegate{
    
    var gameOverLabel:UILabel
    var labelTwo:UILabel
    var mainMenu:UIButton
    var playAgainButton: UIButton
    var adBannerView: ADBannerView = ADBannerView()
    var score:Int
    var textField:UITextField
    var newHighScoreLabel = UILabel()
    var acheivementEarned:Bool
    var audioPlayer = AVAudioPlayer()
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, Score: Int, acheivementEarned:Bool) {
        self.score = Score
        gameOverLabel = UILabel()
        labelTwo = UILabel()
        mainMenu = UIButton()
        playAgainButton = UIButton()
        self.textField = UITextField()
        self.acheivementEarned = acheivementEarned
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTheScore()
        self.addTextField()
        let sizes = self.view.bounds.size
        
        //ganeoverlabel
        gameOverLabel.frame = CGRectMake((sizes.width * (112/320)), (sizes.height * (43/568)), ((sizes.width * (97/320))), (sizes.height * (23/568)))
        gameOverLabel.text = "GameOver"
        gameOverLabel.textColor = UIColor.whiteColor()
        gameOverLabel.font = UIFont(name: "Courier", size: 20)
        self.view.addSubview(gameOverLabel)
        
        //labelTwo
        labelTwo.frame = CGRectMake((sizes.width * (20/320)), (sizes.height * (82/568)), (sizes.width * (280/320)), (sizes.height * (21/568)))
        labelTwo.text = "You did not tap the cat"
        labelTwo.font = UIFont(name: "Courier", size: 20)
        labelTwo.textColor = UIColor.whiteColor()
        self.view.addSubview(labelTwo)
        
        //mainMenuButton
        mainMenu.frame = CGRectMake((sizes.width * (115/320)), (sizes.height * (482/568)), (sizes.width * (85/320)), (sizes.height * (34/568)))
        let mainMenuImage = UIImage(named: "MainMenu.png")
        mainMenu.setImage(mainMenuImage, forState: UIControlState.Normal)
        //mainMenu.setTitle("MainMenu", forState: UIControlState.Normal)
        //mainMenu.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        mainMenu.addTarget(self, action: "mainMenuButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(mainMenu)
        
        //play again
        playAgainButton.frame = CGRectMake((sizes.width * (117/320)), (sizes.height * (438/568)), (sizes.width * (81/320)), (sizes.height * (34/568)))
        let playAgainImage = UIImage(named: "playagain.png")
        playAgainButton.setImage(playAgainImage, forState: UIControlState.Normal)
        //playAgainButton.setTitle("PlayAgain", forState: UIControlState.Normal)
        //playAgainButton.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        playAgainButton.addTarget(self, action: "playAgainPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(playAgainButton)
        
        //adbanner
        let height = (sizes.height * (50/568))
        adBannerView.frame = CGRectMake(0, sizes.height-height, sizes.width, height)
        self.view.addSubview(adBannerView)
        self.canDisplayBannerAds = true
        self.adBannerView.delegate = self
        self.adBannerView.alpha = 0.0
        
        var outOfGameAchievement = checkAchievements()
        //acheivement
        if (acheivementEarned || outOfGameAchievement) {
            var alert = UIAlertView(title: "Achievement", message: "You Earned an Achievement!", delegate: nil, cancelButtonTitle: "Done")
            alert.show()
        }
        
        addStats()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*
    pre: main menu button pressed
    post: introview is loaded
*/
    func mainMenuButtonPressed() {
        buttonSound()
        let mainMenu = introView(nibName: "introViewController", bundle: nil)
        self.presentViewController(mainMenu, animated: true, completion: nil)
    }
    
    
/*
    pre: play again is pressed
    post: play view controller is loaded
*/
    func playAgainPressed() {
        buttonSound()
        let catSelect = CatSelectViewController(nibName: "CatSelectViewController", bundle: nil)
        self.presentViewController(catSelect, animated: true, completion: nil)
    }
    
/* 
    pre: endviewcontroller is loaded
    post: score is posted
*/
    func addTheScore() {
        let sizes = self.view.bounds.size
        let label = UILabel(frame: CGRectMake((sizes.width * (50/320)), (sizes.height * (205/568)), (sizes.width * (300/320)), (sizes.height * (25/668))))
        if (score == 1) {
            label.text = "You tapped \(score) cat"
        }
        else {
            label.text = "You tapped \(score) cats!"
        }
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Courier New", size: 20)
        
        self.view.addSubview(label)
    }
    
/*
    pre: the score is a highscore
    post: uitextview is loaded
*/
    func addTextField() {
        var store = NameScoreStore()
        let sizes = self.view.bounds.size
        if (store.addNewScoreCheck(CInt(score))) {
            self.addNewHighScoreLabel()
            textField.frame = CGRectMake((sizes.width * (85/320)), (sizes.height * (322/568)), (sizes.width * (150/320)), (sizes.height * (21/568)))
            textField.borderStyle = UITextBorderStyle.RoundedRect
            textField.adjustsFontSizeToFitWidth = true
            textField.placeholder = "Enter Your Name!"
            textField.returnKeyType = UIReturnKeyType.Done
            self.view.addSubview(textField)
            textField.delegate = self
        }

       
    }
    
/*
    pre: done button is pressed
    post: keyboard is removed
*/
    func textFieldShouldReturn(textField: UITextField)->Bool {
        self.addHighScore(textField.text)
        textField.resignFirstResponder()
        return true
    }
    
/*
    pre: textField.text length is 8
    post: no more chars allowed for input
*/
    func textField(textField: UITextField,shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var one =  countString(textField.text)
        var two = countString(string)
        var three = range.length
        var newLength = (one + two) - three
        return !(newLength > 8)
    }
    
    
/*
    pre: score is a highscore and name is entered
    post: namescore is added to NameScoreStore
*/
    func addHighScore(text: String) {
        var store = NameScoreStore()
        if (store.addNewScoreCheck(CInt(score)) && text != "") {
            var nameScore = NameScoreItem()
            var nameStoreArray = NameScoreStore()

            if (NameScoreStore().isFull()) {
                nameStoreArray.removeWorstScore()
            }
            nameScore.setName(text)
            nameScore.setScore(CInt(score))
            
            nameStoreArray.addItem(nameScore)
            nameStoreArray.printScores()
            nameStoreArray.saveChanges()
            textField.removeFromSuperview()
            newHighScoreLabel.removeFromSuperview()
        }
    }
    
    func countString(theString: String) ->Int {
        var count = 0
        for ch in theString {
            count++
        }
        return count
    }
    
    func addNewHighScoreLabel() {
        let sizes = self.view.bounds.size
        newHighScoreLabel.frame = CGRectMake((sizes.width * (78/320)), (sizes.height * (290/568)), (sizes.width * (230/320)), (sizes.height * (26/568)))
        newHighScoreLabel.text = "New HighScore!"
        newHighScoreLabel.font = UIFont(name: "Courier New", size: 20)
        newHighScoreLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(newHighScoreLabel)
    }
    
    func addStats(){
        var stats = GameDataStore()
        stats.stats.addScore(Int32(self.score))
        stats.stats.gamePlayed()
        stats.saveChanges()
        println("cats tapped: \(stats.stats.getCatsTapped())")
    }
    
    func checkAchievements()->Bool {
        var stats = GameDataStore()
        var ach = CompletedStore()
        if (stats.stats.getCatsTapped() >= 5000) {
            if (!ach.getItemAtIndex(Int32(7)).getBOOL()) {
                var completed = ach.getItemAtIndex(Int32(7))
                completed.setTRUE()
                ach.addItemAtIndex(Int32(7), item: completed)
                ach.saveChanges()
                return true
            }
        }
        if (stats.stats.getCatsTapped() >= 10000) {
            if (!ach.getItemAtIndex(Int32(8)).getBOOL()) {
                var completed = ach.getItemAtIndex(Int32(8))
                completed.setTRUE()
                ach.addItemAtIndex(Int32(8), item: completed)
                ach.saveChanges()
                return true
            }

        }
        if (stats.stats.getDogsTapped() >= 100) {
            if (!ach.getItemAtIndex(Int32(9)).getBOOL()) {
                var completed = ach.getItemAtIndex(Int32(9))
                completed.setTRUE()
                ach.addItemAtIndex(Int32(9), item: completed)
                ach.saveChanges()
                return true
            }
        }
        if (stats.stats.getDogsTapped() >= 1000) {
            if (!ach.getItemAtIndex(Int32(10)).getBOOL()) {
                var completed = ach.getItemAtIndex(Int32(10))
                completed.setTRUE()
                ach.addItemAtIndex(Int32(10), item: completed)
                ach.saveChanges()
                return true
            }
        }
        if (stats.stats.getGamesPlayed() >= 1000) {
            if (!ach.getItemAtIndex(Int32(11)).getBOOL()) {
                var completed = ach.getItemAtIndex(Int32(11))
                completed.setTRUE()
                ach.addItemAtIndex(Int32(11), item: completed)
                ach.saveChanges()
                return true
            }
        }
        return false
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


