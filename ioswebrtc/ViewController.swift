//
//  ViewController.swift
//  ioswebrtc
//
//  Created by tdtsh on 2018/02/21.
//  Copyright © 2018年 tdtsh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    // ナビゲーションのタイトル変更
    self.navigationItem.title = "iOS WebRTC main"

    // ナビゲーションバーの色を変更
    self.navigationController?.navigationBar.barTintColor = UIColor.darkGray

    // ナビゲーションアイテムの色を変更
    self.navigationController?.navigationBar.tintColor = UIColor.white

    // ナビゲーションタイトルの色を変更
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}
