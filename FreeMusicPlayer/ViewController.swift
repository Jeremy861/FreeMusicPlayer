//
//  ViewController.swift
//  FreeMusicPlayer
//
//  Created by Jeremy Jy on 05/09/2018.
//  Copyright © 2018 Side. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    let colors = [UIColor.blue, UIColor.yellow, UIColor.magenta, UIColor.red, UIColor.brown]
    
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuse", for: indexPath)
        cell.textLabel?.text = animals[indexPath.row]
        cell.backgroundColor = colors[indexPath.row]
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


}

