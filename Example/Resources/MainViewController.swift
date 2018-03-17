//
//  MainViewController.swift
//  Example
//
//  Created by Levi Eggert on 9/16/17.
//  Copyright © 2017 levi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    private let seek: Seek = Seek()
    
    @IBOutlet weak var block: UIView!
    @IBOutlet public var seekSlider: UISlider!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.seek.view = self.block
        self.seek.duration = 0.2
        self.seek.properties.fromAlpha = 0.5
        self.seek.properties.toAlpha = 1
        self.seek.properties.fromTransform = Seek.getTransform(x: 0, y: 0, scaleX: 1, scaleY: 1, rotationDegrees: 0)
        self.seek.properties.toTransform = Seek.getTransform(x: 100, y: 100, scaleX: 1.4, scaleY: 1.4, rotationDegrees: 30)
        
        self.seek.to(position: 0, animated: false)
        self.seekSlider.setValue(0.5, animated: false)
        self.seekSliderValueChanged(slider: self.seekSlider)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    @IBAction func seekSliderValueChanged(slider: UISlider)
    {
        let position: CGFloat = CGFloat(slider.value)
        
        self.seek.to(position: position)
    }
}

