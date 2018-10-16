//
//  ViewController.swift
//  FreeMusicPlayer
//
//  Created by Jeremy Jy on 05/09/2018.
//  Copyright © 2018 Side. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let musics: [String] = ["Michael Jackson", "Weeknd", "Ariana Grande", "Beiju", "Avicii"]
    //let colors = [UIColor.blue, UIColor.brown, UIColor.blue, UIColor.yellow, UIColor.brown]
    
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuse", for: indexPath) as! CustomCell
        cell.cellImage.image = #imageLiteral(resourceName: "beach")
        cell.cellMusicTitle.text = musics[indexPath.row]
        //cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}

