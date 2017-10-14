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
        // Do any additional setup after loading the view, typically from a nib.
        
        self.seek.view = self.block
        self.seek.duration = 0.3
        self.seek.properties.fromAlpha = 0
        self.seek.properties.toAlpha = 1
        self.seek.properties.fromTransform = Seek.getTransform(x: 0, y: 0)
        self.seek.properties.toTransform = Seek.getTransform(x: 80, y: 80)
        
        self.seek.to(position: 0, animated: false)
        self.seekSlider.setValue(0, animated: false)
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

