//
//  ViewController.swift
//  ioswebrtc
//
//  Created by tdtsh on 2018/02/21.
//  Copyright © 2018年 tdtsh. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UIViewController, WebSocketDelegate {

  var socket: WebSocket! = nil
  
  override func viewDidLoad() {

    super.viewDidLoad()

    print("Root:", #function, #line, "start")

    // ナビゲーションのタイトル変更
    self.navigationItem.title = "iOS WebRTC main"

    // ナビゲーションバーの色を変更
    self.navigationController?.navigationBar.barTintColor = UIColor.darkGray

    // ナビゲーションアイテムの色を変更
    self.navigationController?.navigationBar.tintColor = UIColor.white

    // ナビゲーションタイトルの色を変更
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

    // 背景をダークグレーに
    self.view.backgroundColor = UIColor.darkGray

    renderView()
  }

  // Viewを描画する
  func renderView() {
    print("Root:", #function, #line, "start")

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
    print("Root:", #function, #line, "start")

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

  func websocketDidConnect(socket: WebSocketClient) {
    print("Root:", #function, #line, "start")
  }
  
  func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
    print("Root:", #function, #line, "error: \(String(describing: error?.localizedDescription))")
    // LOG("error: \(String(describing: error?.localizedDescription))")
  }

  func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
    print("Root:", #function, #line, "message: \(text)")
  }
  
  func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
    //
    print("Root:", #function, #line, "data: \(data.count)")
  }
  
}
