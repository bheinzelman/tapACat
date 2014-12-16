//
//  EndGameViewController.swift
//  tapACat
//
//  Created by Bert Heinzelman on 6/21/14.
//  Copyright (c) 2014 Tog inc. All rights reserved.
//

import UIKit
import iAd

class EndGameViewController: UIViewController, ADBannerViewDelegate, UITextFieldDelegate{
    
    @IBOutlet var labelOne:UILabel
    @IBOutlet var labelTwo:UILabel
    @IBOutlet var mainMenu:UIButton
    @IBOutlet var playAgainButton: UIButton
    @IBOutlet var adBannerView: ADBannerView
    var score:Int
    var textField:UITextField
    var newHighScoreLabel = UILabel()
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, Score: Int) {
        self.score = Score
        self.textField = UITextField()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTheScore()
        self.addTextField()
        self.canDisplayBannerAds = true
        self.adBannerView.delegate = self
        self.adBannerView.alpha = 0.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*
    pre: main menu button pressed
    post: introview is loaded
*/
    @IBAction func mainMenuButtonPressed(sender : AnyObject) {
        let mainMenu = introView(nibName: "introViewController", bundle: nil)
        self.presentViewController(mainMenu, animated: true, completion: nil)
    }
    
    
/*
    pre: play again is pressed
    post: play view controller is loaded
*/
    @IBAction func playAgainPressed(sender: AnyObject) {
        let playAgain = playViewController(nibName: "playViewController", bundle: nil)
        self.presentViewController(playAgain, animated: true, completion: nil)
    }
    
/* 
    pre: endviewcontroller is loaded
    post: score is posted
*/
    func addTheScore() {
        let label = UILabel(frame: CGRectMake(50, 205, 300, 25))
        if (score == 1) {
            label.text = "You tapped \(score) cat"
        }
        else {
            label.text = "You tapped \(score) cats!"
        }
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Courier New", size: 20)
        
        self.view!.addSubview(label)
    }
    
/*
    pre: the score is a highscore
    post: uitextview is loaded
*/
    func addTextField() {
        var store = NameScoreStore()
        if (store.addNewScoreCheck(CInt(score))) {
            self.addNewHighScoreLabel()
            textField.frame = CGRectMake(85, 322, 150, 21)
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
    func textField(textField: UITextField!,shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
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
        newHighScoreLabel.frame = CGRectMake(78, 290, 230, 26)
        newHighScoreLabel.text = "New HighScore!"
        newHighScoreLabel.font = UIFont(name: "Courier New", size: 20)
        newHighScoreLabel.textColor = UIColor.whiteColor()
        self.view!.addSubview(newHighScoreLabel)
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


