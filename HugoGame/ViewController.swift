//
//  ViewController.swift
//  HugoGame
//
//  Created by Mehmet Eroğlu on 10.04.2019.
//  Copyright © 2019 Mehmet Eroğlu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var hugo1: UIImageView!
    @IBOutlet weak var hugo2: UIImageView!
    @IBOutlet weak var hugo3: UIImageView!
    @IBOutlet weak var hugo4: UIImageView!
    @IBOutlet weak var hugo5: UIImageView!
    @IBOutlet weak var hugo6: UIImageView!
    @IBOutlet weak var hugo7: UIImageView!
    @IBOutlet weak var hugo8: UIImageView!
    @IBOutlet weak var hugo9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var hugoArray = [UIImageView]()
    var hideTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let highScore = UserDefaults.standard.object(forKey: "highScore")
        
        if highScore == nil {
            highScoreLabel.text = "0"
        }
        
        if let newScore = highScore as? Int {
            highScoreLabel.text = String(newScore)
        }
        
//        scoreLabel.text = "Score: \(score)"
         let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        
        hugo1.isUserInteractionEnabled = true
        hugo2.isUserInteractionEnabled = true
        hugo3.isUserInteractionEnabled = true
        hugo4.isUserInteractionEnabled = true
        hugo5.isUserInteractionEnabled = true
        hugo6.isUserInteractionEnabled = true
        hugo7.isUserInteractionEnabled = true
        hugo8.isUserInteractionEnabled = true
        hugo9.isUserInteractionEnabled = true
      
        hugo1.addGestureRecognizer(recognizer1)
        hugo2.addGestureRecognizer(recognizer2)
        hugo3.addGestureRecognizer(recognizer3)
        hugo4.addGestureRecognizer(recognizer4)
        hugo5.addGestureRecognizer(recognizer5)
        hugo6.addGestureRecognizer(recognizer6)
        hugo7.addGestureRecognizer(recognizer7)
        hugo8.addGestureRecognizer(recognizer8)
        hugo9.addGestureRecognizer(recognizer9)
        
        //Timers
        
        counter = 30
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideHugo), userInfo: nil, repeats: true)
        
        
        //HugoArray
        
        hugoArray.append(hugo1)
        hugoArray.append(hugo2)
        hugoArray.append(hugo3)
        hugoArray.append(hugo4)
        hugoArray.append(hugo5)
        hugoArray.append(hugo6)
        hugoArray.append(hugo7)
        hugoArray.append(hugo8)
        hugoArray.append(hugo9)
        
        
        hideHugo()
    }
    
    @objc func hideHugo () {
        
        for hugo in hugoArray {
            hugo.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(hugoArray.count - 1)))
        hugoArray[random].isHidden = false
    }

    @objc func countDown() {
        counter = counter - 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for hugo in hugoArray {
                hugo.isHidden = true
            }
            
            if self.score > Int(self.highScoreLabel.text!)! {
                UserDefaults.standard.set(self.score, forKey: "highScore")
                highScoreLabel.text = String(self.score)
            }
            
            
            let alert = UIAlertController(title: "Time", message: "Time's up", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideHugo), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func increaseScore() {
        score = score + 1
        print(score)
        scoreLabel.text = "Score: \(score)"
    }


}

