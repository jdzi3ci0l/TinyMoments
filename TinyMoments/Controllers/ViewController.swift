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
        entries.append(Entry(date: Date.now, text: "This is a test cell"))
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalEntryCell", for: indexPath) as! JournalEntryCell
//        cell.dateLabel.text = entries[indexPath.row].date.formatted(date: .abbreviated, time: .omitted)
//        cell.shortTextLabel.text = entries[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

