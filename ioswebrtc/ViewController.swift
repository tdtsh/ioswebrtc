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

    renderView()
  }

  // Viewを描画する
  func renderView() {
    print("Master:", #function, #line, "start")

    // ボタン作成
    let buttonEnter = UIButton(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width - 100, height: 50))
    buttonEnter.backgroundColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.7, alpha: 1)

    // 角丸
    buttonEnter.layer.cornerRadius = 5.0
    buttonEnter.layer.masksToBounds = true

    // タイトルとか
    buttonEnter.setTitle("入室", for: UIControlState.normal)

    // 配置
    buttonEnter.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height - 55)
    
    buttonEnter.addTarget(self, action: #selector(self.enterRoom), for: .touchUpInside)
    self.view.addSubview(buttonEnter)
  }

  // DetailControllerを開く
  @objc func enterRoom(_ sender: UIButton) {
    print("Master:", #function, #line, "start")

    // DetailControllerの戻るボタン
    let _backItem = UIBarButtonItem()
    _backItem.title = "戻る"
    navigationItem.backBarButtonItem = _backItem
    let controller = DetailViewController()
    controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
    controller.navigationItem.leftItemsSupplementBackButton = true
    self.navigationController?.pushViewController(controller, animated: true)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}
