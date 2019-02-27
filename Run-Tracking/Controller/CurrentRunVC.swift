//
//  CurrentRunVC.swift
//  Run-Tracking
//
//  Created by sHiKoOo on 2/27/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class CurrentRunVC: LocationVC {

    @IBOutlet weak var swipeBGImage: UIImageView!
    @IBOutlet weak var sliderImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender:)))
        sliderImage.addGestureRecognizer(swipeGesture)
        sliderImage.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc func endRunSwiped(sender: UIPanGestureRecognizer) {
        // make the slider image moves on x
        let minAdjust: CGFloat = 73
        let maxAdjust: CGFloat = 122
        if let sliderView = sender.view {
            if sender.state == UIGestureRecognizer.State.began || sender.state == UIGestureRecognizer.State.changed {
                let translation = sender.translation(in: self.view)
                if sliderView.center.x >= (swipeBGImage.center.x - minAdjust) && sliderView.center.x <= (swipeBGImage.center.x + maxAdjust) {
                    sliderView.center.x = sliderView.center.x + translation.x
                }else if sliderView.center.x >= swipeBGImage.center.x + maxAdjust {
                    sliderView.center.x = swipeBGImage.center.x + maxAdjust
                    // End run codes
                    dismiss(animated: true, completion: nil)
                }else {
                    sliderView.center.x = swipeBGImage.center.x - minAdjust
                }
                sender.setTranslation(CGPoint.zero, in: self.view)
            }else if sender.state == UIGestureRecognizer.State.ended {
                UIView.animate(withDuration: 0.1) {
                    sliderView.center.x = self.swipeBGImage.center.x - minAdjust
                }
            }
        }
    }



}
