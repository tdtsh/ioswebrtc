//
//  DetailViewController.swift
//  ioswebrtc
//
//  Created by tdtsh on 2018/03/01.
//  Copyright © 2018年 tdtsh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  override func viewDidLoad() {

    super.viewDidLoad()

    print("Detail:", #function, #line, "start")

    // 背景をダークグレーに
    self.view.backgroundColor = UIColor.darkGray

    // ナビゲーションのタイトル変更
    self.navigationItem.title = "iOS WebRTC detail"

    renderView()
  }

  // Viewを描画する
  func renderView() {
    print("Detail:", #function, #line, "start")

    // Connectボタン作成
    let buttonConnect = UIButton(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width / 3, height: 50))
    buttonConnect.backgroundColor = UIColor.init(red: 0.2, green: 0.3, blue: 0.7, alpha: 1)
    buttonConnect.layer.cornerRadius = 5.0
    buttonConnect.layer.masksToBounds = true
    buttonConnect.setTitle("Connect", for: UIControlState.normal)
    buttonConnect.layer.position = CGPoint(x: self.view.bounds.width/4, y:self.view.bounds.height - 60)
    self.view.addSubview(buttonConnect)

    // Hangupボタン作成
    let buttonHangup = UIButton(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width / 3, height: 50))
    buttonHangup.backgroundColor = UIColor.init(red: 0.7, green: 0.3, blue: 0.1, alpha: 1)
    buttonHangup.layer.cornerRadius = 5.0
    buttonHangup.layer.masksToBounds = true
    buttonHangup.setTitle("Hangup", for: UIControlState.normal)
    buttonHangup.layer.position = CGPoint(x: (self.view.bounds.width/4)*3, y:self.view.bounds.height - 60)
    self.view.addSubview(buttonHangup)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}
