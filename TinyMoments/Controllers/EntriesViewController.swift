//
//  EntriesViewController.swift
//  TinyMoments
//
//  Created by Janusz on 06/04/2022.
//

import UIKit

class EntriesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var entries = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.register(UINib(nibName: "JournalEntryCell", bundle: nil), forCellReuseIdentifier: "JournalEntryCell")
        entries.append(Entry(title: "First Day Of My Travel", text: "Today we visited a lot of amazing places and many things happened.", mood: "happy"))
        entries.append(Entry(title: "My birthday party", text: "Today was my birthday, so I wanted to record the best moments", mood: "party"))
        entries.append(Entry(date: Date.init(timeIntervalSince1970: 300000), title: "Another Test Entry", text: "I wish I was better at working with UIKit, Autolayout and Constraints. I will get better, I promise!", mood: "cool"))
        
        
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: #colorLiteral(red: 0.486708045, green: 0.4391390383, blue: 0.5955944061, alpha: 1),
            .font: UIFont(name: "Pacifico-Regular", size: 17)!
        ]
    }
    
    func saveEntries() {
        //Saving entries
        tableView.reloadData()
    }
    
    func loadEntries() {
        //Loading entries
        tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Entry", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Title"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            let text = alert.textFields!.first!.text ?? ""
            if !text.isEmpty {
                let newEntry = Entry(title: text)
                self.entries.append(newEntry)
                self.saveEntries()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension EntriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalEntryCell", for: indexPath) as! JournalEntryCell
        
        let entry = entries[indexPath.row]
        
        cell.dayLabel.text = String(entry.date.day!)
        cell.monthLabel.text = entry.date.monthAsString()
        cell.titleLabel.text = entry.title
        cell.descriptionLabel.text = entry.text
        if let mood = entry.mood {
            cell.moodImageView.image = UIImage(named: mood)
        } else {
            cell.moodImageView.image = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetail" {
            
        }
    }
}

