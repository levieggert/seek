//
//  Created by Levi Eggert.
//  Copyright © 2020 Levi Eggert. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var viewSeeks: [Seek] = Array()
    private var redBlockSeek: Seek!
    private var tealBlockSeek: Seek!
    private var didLayoutSubviews: Bool = false
    
    @IBOutlet weak private var redBlock: UIView!
    @IBOutlet weak private var tealBlock: UIView!
    @IBOutlet weak private var seekSlider: UISlider!
    
    @IBOutlet weak private var tealBlockLeading: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard !didLayoutSubviews else {
            return
        }
        
        didLayoutSubviews = true
        
        redBlockSeek = Seek(
            view: redBlock,
            seekProperties: [
                .alpha(seekFloat: SeekFloat(fromValue: 0.5, toValue: 1)),
                .transform(seekTransform: SeekTransform(
                    fromValue: SeekTransform.getTransform(x: 0, y: 0, scaleX: 1, scaleY: 1, rotationDegrees: 0),
                    toValue: SeekTransform.getTransform(x: 100, y: 100, scaleX: 1.4, scaleY: 1.4, rotationDegrees: 30)))
        ])
        
        tealBlockSeek = Seek(
            view: tealBlock,
            constraint: tealBlockLeading,
            constraintLayoutView: view,
            seekProperties: [
                .constraints(seekFloat: SeekFloat(fromValue: 0, toValue: view.bounds.size.width - tealBlock.frame.size.width)),
                .transform(seekTransform: SeekTransform(
                    fromValue: SeekTransform.getTransform(x: 0, y: 0, scaleX: 1, scaleY: 1, rotationDegrees: 0),
                    toValue: SeekTransform.getTransform(x: 0, y: 0, scaleX: 2, scaleY: 2, rotationDegrees: 50)))
        ])
        
        viewSeeks = [redBlockSeek, tealBlockSeek]
        
        seekSlider.setValue(0.5, animated: false)
        seekSliderValueChanged(slider: seekSlider)
        
        seekSlider.addTarget(self, action: #selector(seekSliderValueChanged(slider:)), for: .valueChanged)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)        
    }
    
    @objc func seekSliderValueChanged(slider: UISlider) {
        
        let position: CGFloat = CGFloat(slider.value)
               
        for seek in viewSeeks {
            
            seek.animateTo(
                position: position,
                duration: 0.05,
                delay: 0,
                animationOptions: .curveEaseOut,
                complete: nil
            )
        }
        
        
    }
}

