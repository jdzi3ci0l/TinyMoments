//
//  EntriesViewController.swift
//  TinyMoments
//
//  Created by Janusz on 06/04/2022.
//

import UIKit
import CoreData

class EntriesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var entries = [Entry]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.register(UINib(nibName: "JournalEntryCell", bundle: nil), forCellReuseIdentifier: "JournalEntryCell")
    
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: #colorLiteral(red: 0.486708045, green: 0.4391390383, blue: 0.5955944061, alpha: 1),
            .font: UIFont(name: "Pacifico-Regular", size: 17)!
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadEntries()
        tableView.reloadData()
    }
    
    func saveEntries() {
        do {
            try context.save()
        } catch {
            print("Error saving entries: \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    func loadEntries() {
        let request: NSFetchRequest<Entry> = Entry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
        entries = try context.fetch(request)
        } catch {
            print("Error loading entries: \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Entry", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Title"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            let title = alert.textFields!.first!.text ?? ""
            if !title.isEmpty {
                let newEntry = Entry(context: self.context)
                newEntry.date = Date.now
                newEntry.title = title
                
                self.entries.insert(newEntry, at: 0)
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
        
        cell.dayLabel.text = String(entry.date!.day!)
        cell.monthLabel.text = entry.date!.monthAsString()
        cell.titleLabel.text = entry.title
        cell.descriptionLabel.text = entry.text
        if let mood = entry.mood {
            cell.moodEmoji.text = mood
        } else {
            cell.moodEmoji.text = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetail" {
            let index = tableView.indexPathForSelectedRow!.row
            let entry = entries[index]
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.entry = entry
        }
    }
}

