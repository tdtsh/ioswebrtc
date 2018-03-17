//
//  DetailViewController.swift
//  ioswebrtc
//
//  Created by tdtsh on 2018/03/01.
//  Copyright © 2018年 tdtsh. All rights reserved.
//

import UIKit
import WebRTC
import Starscream

class DetailViewController: UIViewController, WebSocketDelegate {

  var socket: WebSocket! = nil

  var remoteVideoView: RTCEAGLVideoView!
  var cameraPreview: RTCCameraPreviewView!
  
  var peerConnectionFactory: RTCPeerConnectionFactory! = nil
  var audioSource: RTCAudioSource?
  var videoSource: RTCAVFoundationVideoSource?

  override func viewDidLoad() {

    super.viewDidLoad()

    print("Detail:", #function, #line, "start")

    // 背景をダークグレーに
    self.view.backgroundColor = UIColor.darkGray

    // ナビゲーションのタイトル変更
    self.navigationItem.title = "iOS WebRTC detail"

    renderView()

    initWS()
  }

  // WebScoketサーバに接続する
  func initWS() {
    print("Detail:", #function, #line, "start")
    socket = WebSocket(url: URL(string: "ws://localhost:4000/")!)
    socket.delegate = self
    socket.connect()
  }

  // Viewを描画する
  func renderView() {
    print("Detail:", #function, #line, "start")

    // VideoViewを生成
    remoteVideoView = RTCEAGLVideoView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    self.view.addSubview(remoteVideoView)

    // プレビューを作成
    cameraPreview = RTCCameraPreviewView.init(frame: CGRect.init(x: self.view.frame.width - 120, y: 84, width: 100, height: 100))
    cameraPreview.backgroundColor = UIColor.gray
    self.view.addSubview(cameraPreview)

    // Connectボタン作成
    let buttonConnect = UIButton(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width / 3, height: 50))
    buttonConnect.backgroundColor = UIColor.init(red: 0.2, green: 0.3, blue: 0.7, alpha: 1)
    buttonConnect.layer.cornerRadius = 5.0
    buttonConnect.layer.masksToBounds = true
    buttonConnect.setTitle("Connect", for: UIControlState.normal)
    buttonConnect.layer.position = CGPoint(x: self.view.bounds.width/4, y:self.view.bounds.height - 60)
    buttonConnect.addTarget(self, action: #selector(self.connect), for: .touchUpInside)
    self.view.addSubview(buttonConnect)

    // Hangupボタン作成
    let buttonHangup = UIButton(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width / 3, height: 50))
    buttonHangup.backgroundColor = UIColor.init(red: 0.7, green: 0.3, blue: 0.1, alpha: 1)
    buttonHangup.layer.cornerRadius = 5.0
    buttonHangup.layer.masksToBounds = true
    buttonHangup.setTitle("Hangup", for: UIControlState.normal)
    buttonHangup.layer.position = CGPoint(x: (self.view.bounds.width/4)*3, y:self.view.bounds.height - 60)
    buttonHangup.addTarget(self, action: #selector(self.hangup), for: .touchUpInside)
    self.view.addSubview(buttonHangup)
  }

  // 通話を開始する
  @objc func connect(_ sender: UIButton) {
    print("Detail:", #function, #line, "start")
  }

  // 通話を終了する
  @objc func hangup(_ sender: UIButton) {
    print("Detail:", #function, #line, "start")

    socket.disconnect()

    // 戻る
    self.navigationController!.popViewController(animated: true)
    self.dismiss(animated: true, completion: nil)

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func websocketDidConnect(socket: WebSocketClient) {
    print("Detail:", #function, #line, "start")
  }

  func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
    print("Detail:", #function, #line, "error: \(String(describing: error?.localizedDescription))")
    // LOG("error: \(String(describing: error?.localizedDescription))")
  }

  func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
    print("Detail:", #function, #line, "message: \(text)")
  }

  func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
    //
    print("Detail:", #function, #line, "data: \(data.count)")
  }

}
