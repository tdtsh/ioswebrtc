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

class DetailViewController: UIViewController, WebSocketDelegate, RTCPeerConnectionDelegate {

  var socket: WebSocket! = nil

  var peerConnectionFactory: RTCPeerConnectionFactory! = nil
  var peerConnection: RTCPeerConnection! = nil
  var audioSource: RTCAudioSource?
  var videoSource: RTCAVFoundationVideoSource?

  var cameraPreview: RTCCameraPreviewView!
  var remoteVideoView: RTCEAGLVideoView!

  override func viewDidLoad() {

    super.viewDidLoad()

    print("Detail:", #function, #line, "start")

    // 背景をダークグレーに
    self.view.backgroundColor = UIColor.darkGray

    // ナビゲーションのタイトル変更
    self.navigationItem.title = "iOS WebRTC detail"

    renderView()

    peerConnectionFactory = RTCPeerConnectionFactory()

    startVideo()

    initWS()
  }

  // WebScoketサーバに接続する
  func initWS() {
    print("Detail:", #function, #line, "start")

    // websocket初期化
    //socket = WebSocket(url: URL(string: "ws://172.16.1.10:4000/")!)
    socket = WebSocket(url: URL(string: "ws://localhost:4000/")!)
    //socket = WebSocket(url: URL(string: "ws://simplesingalingserver-spuwvkveth.now.sh")!)
    socket.delegate = self
    socket.connect()
    socket.onConnect = {
      print("Detail:", #function, #line, "oncoonect")
    }
  }

  // 映像配信を開始する
  func startVideo() {
    print("Detail:", #function, #line, "start")

    // 音声ソース
    let audioSourceConstraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
    audioSource = peerConnectionFactory.audioSource(with: audioSourceConstraints)

    // 映像ソース
    let videoSourceConstraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
    videoSource = peerConnectionFactory.avFoundationVideoSource(with: videoSourceConstraints)

    // 映像ソースをプレビューに設定
    cameraPreview.captureSession = videoSource?.captureSession
  }


  //RTCPeerConnectionの作成
  func prepareNewConnection() -> RTCPeerConnection {
    print("Detail:", #function, #line, "start")
    // STUN/TURN　設定
    let configuration = RTCConfiguration()
    configuration.iceServers = [RTCIceServer.init(urlStrings: ["stun:stun.l.google.com:19302"])]

    // PeerConnection設定
    let peerConnectionConstraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)

    // PeerConnectionの初期化
    let peerConnection = peerConnectionFactory.peerConnection(with: configuration, constraints: peerConnectionConstraints, delegate: self)

    // 音声トラックの作成
    let localAudioTrack = peerConnectionFactory.audioTrack(with: audioSource!, trackId: "testa0")
    // PeerConnectionからSenderを作成
    let audioSender = peerConnection.sender(withKind: kRTCMediaStreamTrackKindAudio, streamId: "test")
    audioSender.track = localAudioTrack

    // 映像トラックの作成
    let localVideoTrack = peerConnectionFactory.videoTrack(with: videoSource!, trackId: "testv0")
    // PeerConnectionからVideoのSenderを作成
    let videoSender = peerConnection.sender(withKind: kRTCMediaStreamTrackKindVideo, streamId: "test")
    videoSender.track = localVideoTrack

    return peerConnection
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
    buttonHangup.addTarget(self, action: #selector(self.hangupButtonAction), for: .touchUpInside)
    self.view.addSubview(buttonHangup)
  }

  // 通話を開始する
  @objc func connect(_ sender: UIButton) {
    print("Detail:", #function, #line, "start")
    if peerConnection == nil {
      peerConnection = prepareNewConnection()
    }
  }

  // 通話を終了する
  @objc func hangupButtonAction(_ sender: UIButton) {
    print("Detail:", #function, #line, "start")
    hangup()
  }

  func hangup() {
    print("Detail:", #function, #line, "start")

    socket.disconnect()
    if peerConnection != nil {
        if peerConnection.iceConnectionState != RTCIceConnectionState.closed {
            peerConnection.close()
        }
        peerConnection = nil
        print("Detail:", #function, #line, "peerConnection closed")
    }

    leave()
  }

  func leave() {
    // 戻る
    self.navigationController!.popViewController(animated: true)
    self.dismiss(animated: true, completion: nil)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  deinit {
    if peerConnection != nil {
        hangup()
    }
    audioSource = nil
    videoSource = nil
    peerConnectionFactory = nil
  }

  /**************************************************/
  /* Websocket                                      */
  /**************************************************/
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
    print("Detail:", #function, #line, "data: \(data.count)")
  }

  /**************************************************/
  /* WebRTC                                         */
  /**************************************************/
  // 接続情報交換の状況が変化した
  func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
    print("Detail:", #function, #line, "start")
  }

  // 映像/音声streamが追加された
  func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
    print("Detail:", #function, #line, "start")
  }

  // 映像/音声streamが削除された
  func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
    print("Detail:", #function, #line, "start")
  }

  // 接続情報の交換が必要になった
  func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
    print("Detail:", #function, #line, "start")
  }

  // PeerConnectionの接続状況が変化した
  func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
    print("Detail:", #function, #line, "start")
  }

  // 接続先候補の探索状況が変化した
  func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
    print("Detail:", #function, #line, "start")
  }

  // Candidate(自分への接続先候補情報)が生成された
  func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
    print("Detail:", #function, #line, "start")
  }

  // DataChannelが作られた
  func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
    print("Detail:", #function, #line, "start")
  }

  // Candidateが削除された
  func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
    print("Detail:", #function, #line, "start")
  }

}
