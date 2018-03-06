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

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}
