//
//  ViewController.swift
//  FHXScoreView
//
//  Created by fenghanxu on 08/08/2018.
//  Copyright (c) 2018 fenghanxu. All rights reserved.
//

import UIKit
import FHXScoreView

class ViewController: UIViewController {
  
  fileprivate let startView = ScoreView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

      startView.score = 50

      view.addSubview(startView)

//      startView.isUserInteractionEnabled = false

      startView.snp.makeConstraints { (make) in

        make.center.equalToSuperview()
        make.height.equalTo(12)
        make.width.equalTo(100)
      }
      
    }



}

