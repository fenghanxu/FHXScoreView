//
//  ScoreView.swift
//  B7iOSBuy
//
//  Created by BigL on 2016/11/29.
//  Copyright © 2016年 www.spzjs.com. All rights reserved.
//

import UIKit
import SnapKit

public protocol ScoreViewDelegate: AnyObject {
  func scoreView(view:ScoreView,score: Int)
}

public class ScoreView: UIView {
  
  weak var delegate: ScoreViewDelegate?

  fileprivate let nilIcon = UIImageView(image: Asserts.findImages(named: "icon-star-nil"))
  fileprivate let fillView = UIView()
  fileprivate let fillIcon = UIImageView(image: Asserts.findImages(named: "icon-star-fill"))
  
  var minScore: Int = 0
  var maxScore: Int = 50
		
  public var score: Int = 0{
    didSet{
      if score == oldValue { return }
      drawLayer(scale: CGFloat(score) / 50)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    buildUI()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    buildUI()
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
    drawLayer(scale: CGFloat(score) / 50)
  }
  
}

// MARK: - UI配置
extension ScoreView{
  
  fileprivate func buildUI() {
    layer.masksToBounds = true
    addSubview(nilIcon)
    addSubview(fillView)
    fillView.addSubview(fillIcon)
    buildLayout()
    buildSubView()
    buildGestures()
  }
  
  private func buildLayout() {
    self.snp.makeConstraints { (make) in
      make.width.equalTo(self.snp.height).multipliedBy(7.5)
    }
    
    nilIcon.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalToSuperview()
    }
    fillIcon.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalTo(nilIcon)
    }
  }
  
  private func buildSubView() {
    fillView.layer.masksToBounds = true
  }
  
  func buildGestures() {
    let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(pan:)))
    pan.delegate = self
    let tap = UITapGestureRecognizer(target: self, action: #selector(tap(tap:)))
    tap.delegate = self
    addGestureRecognizer(pan)
    addGestureRecognizer(tap)
  }
}

extension ScoreView{
  
  fileprivate func sendDelegate(point: CGPoint) {
    let temp = Int(ceil((point.x / width) * 5) * 10)
    guard temp != score else { return }
    
    score = temp < minScore ? minScore: temp
    score = score > maxScore ? maxScore: score
    delegate?.scoreView(view: self, score: score)
  }
  
  fileprivate func drawLayer(scale: CGFloat) {
    fillView.frame = CGRect(x: 0, y: 0, width: width * scale, height: height)
  }
  
}

extension ScoreView: UIGestureRecognizerDelegate{
  
  @objc func tap(tap: UITapGestureRecognizer) {
    let pt: CGPoint = tap.location(in: self)
    sendDelegate(point: pt)
  }
  
  @objc func pan(pan: UIPanGestureRecognizer) {
    let pt: CGPoint = pan.location(in: self)
    sendDelegate(point: pt)
  }
  
  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}



