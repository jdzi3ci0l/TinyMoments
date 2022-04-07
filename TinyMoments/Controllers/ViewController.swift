//
//  ViewController.swift
//  TinyMoments
//
//  Created by Janusz on 06/04/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var entries = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.register(UINib(nibName: "JournalEntryCell", bundle: nil), forCellReuseIdentifier: "JournalEntryCell")
        entries.append(Entry(date: Date.now, title: "First Day Of My Travel", text: "Today we visited a lot of amazing places and many things happened.", mood: "happy"))
        entries.append(Entry(date: Date.now, title: "My birthday party", text: "Today was my birthday, so I wanted to record the best moments"))
        entries.append(Entry(date: Date.init(timeIntervalSince1970: 300000), title: "Another Test Entry", text: "I wish I was better at working with UIKit, Autolayout and Constraints. I will get better, I promise!"))
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalEntryCell", for: indexPath) as! JournalEntryCell
        
        let entry = entries[indexPath.row]
        
        cell.dayLabel.text = String(entry.date.day!)
        cell.monthLabel.text = entry.date.monthAsString()
        cell.titleLabel.text = entry.title
        cell.descriptionLabel.text = entry.text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

