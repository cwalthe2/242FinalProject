//
//  LeaderboardProgress.swift
//  U O ME
//
//  Created by Collin Walther on 11/25/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import UIKit

class LeaderboardProgress: UIView {
    
    private var backgroundImage : UIView!
    private var progressView : UIView!
    private let animationDuration : Double = 0.6
    var rank: Int = 0
    var rankPoints: Int = 0
    
    // MARK: - Overriden Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func fetchRank(){
        //TODO fetch data from server
        rank = 1
        rankPoints = 0
    }
    

    // MARK: - Public Methods
    /**
     Initializes the progress bar background and also the progress level view.
     The background is equal to the parent view frame.
     */
    func initBar() {
        fetchRank()
        // make the container with rounded corners and clear background.
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.clear
        
        // background image / this view being the same width and height as the parent doesn't need to round the corners. It will take the parent frame.
        let backgroundRect = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        backgroundImage = UIView(frame: backgroundRect)
        backgroundImage.clipsToBounds = true
        backgroundImage.backgroundColor = UIColor.yellow
        addSubview(backgroundImage)
        
        //level of progress
        let progressRect = CGRect(x: 0.0, y: 0, width: 0, height: self.frame.size.height)
        progressView = UIView(frame: progressRect)
        progressView.layer.masksToBounds = true
        progressView.backgroundColor = UIColor.blue
        addSubview(progressView)
        //self.setProgressValue(currentValue: 0)
    }

    
    func setProgress(value : CGFloat) {
        let xOffset = ((100.0 - value) / 100.0) * frame.size.width
        if self.progressView.frame.size.width <= self.frame.size.width - xOffset{
            UIView.animate(withDuration: self.animationDuration, delay: 0, options: [.curveEaseInOut], animations: {
                self.progressView.frame.size.width = self.frame.size.width - xOffset
                //self.progressView.frame.origin.x = yOffset
            }, completion: nil)
        }
        else{
            UIView.animate(withDuration: self.animationDuration, delay: 0, options: [.curveEaseInOut], animations: {
                self.progressView.frame.size.width = self.frame.size.width
            }, completion: { (finished: Bool) -> Void in
                self.progressView.frame.size.width = 0
                self.setProgress(value: value)
            })
        }
    }
    /**
     Sets the background color of the progress view.
     This color will be displayed underneath the progress view.
     */
    func setBackColor(color : UIColor) {
        backgroundImage.backgroundColor = color
    }
    /**
     Sets the background color of the progress view.
     This is the color that will display the value you have inserted.
     */
    private func setProgressColor(color : UIColor) {
        progressView.backgroundColor = color
    }
    
    
    // 1 - 10
    // 2 - 10
    // 3 - 10
    // 4 - 10
    // 5 - 10
    // 6 - 15
    // 7 - 15
    // 8 - 15
    // 9 - 15
    // 10 - 20
    // 11 - 20
    // 12 - 20
    // 13 - 25
    // 14 - 25
    // 15 - 30
    func addPoints(points: Int){
        let maxPoints: Int = Int(getMaxPointsFromRank())
        
        addPointsHelper(pointsToAdd: points, currPoints: rankPoints, maxPoints: maxPoints)
    }
    
    func addPointsHelper(pointsToAdd: Int, currPoints: Int, maxPoints: Int){
        if (currPoints + pointsToAdd) >= maxPoints{
            rank += 1
            rankPoints = currPoints + pointsToAdd - (maxPoints)
        }
        else{
            rankPoints = currPoints + pointsToAdd
        }
        
        let nextMaxPoint: CGFloat = getMaxPointsFromRank()
        
        let n = CGFloat(rankPoints) / nextMaxPoint
        //print(n)
        self.setProgress(value: n*100)
    }
    
    private func getMaxPointsFromRank() -> CGFloat{
        if rank >= 1 && rank <= 5{
            return 10
        }
        else if rank >= 6 && rank <= 9{
            return 15
        }
        else if rank >= 10 && rank <= 12{
            return 20
        }
        else if rank >= 13 && rank <= 14{
            return 25
        }
        else{
            return 30
        }
        
    }
    
    func getRank() -> Int{
        return rank
    }
    
    func getRankPoints() -> Int{
        return rankPoints
    }
}
    



