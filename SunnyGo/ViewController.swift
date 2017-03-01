//
//  ViewController.swift
//  SunnyGo
//
//  Created by nickyslicks on 2/22/17.
//  Copyright © 2017 nickyslicks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Create and add a colored square
        var color1 = hexStringToUIColor(hex: "#7EC0EE")
        self.view.backgroundColor = color1
        let coloredSquare = UIImageView()
        let imagename = "sunnygo.png"
        coloredSquare.image = UIImage(named: imagename)
        // set background color to blue
        //coloredSquare.backgroundColor = UIColor.blue
        
        // set frame (position and size) of the square
        // iOS coordinate system starts at the top left of the screen
        // so this square will be at top left of screen, 50x50pt
        // CG in CGRect stands for Core Graphics
        coloredSquare.frame = CGRect(x: 60, y: 220, width: 180, height: 180)
        
        // finally, add the square to the screen
        self.view.addSubview(coloredSquare)
        // lets set the duration to 1.0 seconds
        // and in the animations block change the background color
        // to red and the x-position  of the frame


        UIView.animate(withDuration: 4.5, delay: 0.3, options: [.repeat, .curveEaseOut, .autoreverse], animations: {
            //coloredSquare.backgroundColor = UIColor.red
            
            // for the x-position I entered 320-50 (width of screen - width of the square)
            // if you want, you could just enter 270
            // but I prefer to enter the math as a reminder of what's happenings
            coloredSquare.frame = CGRect(x: 320-70, y: 240, width: 180, height: 180)
        })

        // loop for 10 times
        for loopNumber in 0...100 {
            
            // set up some constants for the animation
            let duration : TimeInterval = ( TimeInterval(arc4random_uniform(20)+5))
            let delay : TimeInterval = (TimeInterval(arc4random_uniform(800)))
            
            // set up some constants for the fish
            let size : CGFloat = CGFloat( arc4random_uniform(40))+60
            let yPosition : CGFloat = CGFloat( arc4random_uniform(500))+10
            
            // create the fish and add it to the screen
            let cloud = UIImageView()
            
            cloud.image = UIImage(named: "cloud.png")
            //cloud.backgroundColor = UIColor.green
            cloud.frame = CGRect(x: -150, y: yPosition, width:size+(size/4), height:size)
            self.view.addSubview(cloud)
            
            // define the animation
            UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
                
                // move the fish
                cloud.frame = CGRect(x: 320-size+60, y: yPosition, width: size, height: size)
                
            }, completion: { animationFinished in
                
                // remove the fish
                cloud.removeFromSuperview()
                
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

