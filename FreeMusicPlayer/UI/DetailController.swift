//
//  DetailController.swift
//  FreeMusicPlayer
//
//  Created by Jeremy Jy on 03/10/2018.
//  Copyright © 2018 Side. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class DetailController: UIViewController {
    
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var seekingTitle: UILabel!
    @IBOutlet weak var songAddInfo: UILabel!
    @IBOutlet weak var songSlider: UISlider!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var playList: NSMutableArray = NSMutableArray()
    var timer: Timer?
    var index: Int = Int()
    var avPlayer: AVPlayer!
    var isPaused: Bool!
    
    var toplay = Playlists(title: "toplay")
    
    //MARK: - Old stuff
    var media:  StoreItem?{
        didSet{
            guard let media = media else {
                return
            }
            self.loadViewIfNeeded()
            self.navigationItem.title = media.name
            self.mediaLabel.text = "\(media)"
        }
    }
    @IBOutlet weak var mediaLabel: UILabel!
    
    //MARK: - Initialisation + music list
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isPaused = false
        playButton.setImage(UIImage(named:"pause"), for: .normal)
        
        //Sample music
        toplay.loadSamplePlaylist()
        self.play(url: URL(string:(toplay.Songs[self.index].songURL))!)
        self.setupTimer()
        songTitle.text = toplay.Songs[self.index].title
        songAddInfo.text = toplay.Songs[self.index].artist
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear( _ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        self.avPlayer = nil
        self.timer?.invalidate()
    }
    
    //MARK: - Song Nav
    func play(url:URL) {
        self.avPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
        if #available(iOS 10.0, *) {
            self.avPlayer.automaticallyWaitsToMinimizeStalling = false
        }
        avPlayer!.volume = 2.0
        avPlayer.play()
    }
    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        //if #available(iOS 10.0, *) {
            self.togglePlayPause()
        //} else {
            // showAlert "upgrade ios version to use this feature"
        //}
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        self.nextTrack()
    }
    func nextTrack(){
        if(index < toplay.Songs.count-1){
            index = index + 1
            isPaused = false
            playButton.setImage(UIImage(named:"pause"), for: .normal)
            self.play(url: URL(string:(toplay.Songs[self.index].songURL))!)
            
        }else{
            index = 0
            isPaused = false
            playButton.setImage(UIImage(named:"pause"), for: .normal)
            self.play(url: URL(string:(toplay.Songs[self.index].songURL))!)
            
        }
        songTitle.text = toplay.Songs[self.index].title
        songAddInfo.text = toplay.Songs[self.index].artist
    }
    
    @IBAction func previousButtonClicked(_ sender: Any) {
        self.prevTrack()
    }
    func prevTrack(){
        if(index > 0){
            index = index - 1
            isPaused = false
            playButton.setImage(UIImage(named:"pause"), for: .normal)
            self.play(url: URL(string:(toplay.Songs[self.index].songURL))!)
            songTitle.text = toplay.Songs[self.index].title
            songAddInfo.text = toplay.Songs[self.index].artist
        }
    }
    
    //@available(iOS 10.0, *)
    func togglePlayPause() {
        if avPlayer.timeControlStatus == .playing  {
            playButton.setImage(UIImage(named:"play"), for: .normal)
            avPlayer.pause()
            isPaused = true
        } else {
            playButton.setImage(UIImage(named:"pause"), for: .normal)
            avPlayer.play()
            isPaused = false
        }
    }
    
    @objc func didPlayToEnd() {
        self.nextTrack()
    }
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        let seconds : Int64 = Int64(sender.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        avPlayer!.seek(to: targetTime)
        if(isPaused == false){
            seekingTitle.alpha = 1
        }
    }
    
    @IBAction func sliderTapped(_ sender: UILongPressGestureRecognizer) {
        if let slider = sender.view as? UISlider {
            if slider.isHighlighted { return }
            let point = sender.location(in: slider)
            let percentage = Float(point.x / slider.bounds.width)
            let delta = percentage * (slider.maximumValue - slider.minimumValue)
            let value = slider.minimumValue + delta
            slider.setValue(value, animated: false)
            let seconds : Int64 = Int64(value)
            let targetTime:CMTime = CMTimeMake(seconds, 1)
            avPlayer!.seek(to: targetTime)
            if(isPaused == false){
                seekingTitle.alpha = 1
            }
        }
    }
    
    //MARK: - TIME related
    func setupTimer(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.didPlayToEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        timer = Timer(timeInterval: 0.001, target: self, selector: #selector(DetailController.tick), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    @objc func tick(){
        if(avPlayer.currentTime().seconds == 0.0){
            //songTitle.alpha = 1
        }else{
            //songTitle.alpha = 0
        }
        
        if(isPaused == false){
            if(avPlayer.rate == 0){
                avPlayer.play()
                seekingTitle.alpha = 1
            }else{
                seekingTitle.alpha = 0
            }
        }
        
        if((avPlayer.currentItem?.asset.duration) != nil){
            let currentTime1 : CMTime = (avPlayer.currentItem?.asset.duration)!
            let seconds1 : Float64 = CMTimeGetSeconds(currentTime1)
            let time1 : Float = Float(seconds1)
            songSlider.minimumValue = 0
            songSlider.maximumValue = time1
            let currentTime : CMTime = (self.avPlayer?.currentTime())!
            let seconds : Float64 = CMTimeGetSeconds(currentTime)
            let time : Float = Float(seconds)
            self.songSlider.value = time
            let currentTimeToDisplay = Int32(Float(Float64(CMTimeGetSeconds((self.avPlayer?.currentItem?.currentTime())!))))
            let totalTimeToDisplay = Int32(Float(Float64(CMTimeGetSeconds((self.avPlayer?.currentItem?.asset.duration)!))))
            timeLabel.text =  self.formatTimeFromSeconds(totalSeconds:(totalTimeToDisplay-currentTimeToDisplay))
            
            
        }else{
            songSlider.value = 0
            songSlider.minimumValue = 0
            songSlider.maximumValue = 0
            timeLabel.text = "Live stream \(self.formatTimeFromSeconds(totalSeconds: Int32(CMTimeGetSeconds((avPlayer.currentItem?.currentTime())!))))"
        }
    }
    
    func formatTimeFromSeconds(totalSeconds: Int32) -> String {
        let seconds: Int32 = totalSeconds%60
        let minutes: Int32 = (totalSeconds/60)%60
        let hours: Int32 = totalSeconds/3600
        return String(format: "%02d:%02d:%02d", hours,minutes,seconds)
    }
}
extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
