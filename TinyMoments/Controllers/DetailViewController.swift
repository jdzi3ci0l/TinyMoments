//
//  DetailViewController.swift
//  TinyMoments
//
//  Created by Janusz on 09/04/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var entry: Entry!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var moodImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [#colorLiteral(red: 0.8518229127, green: 0.8488650322, blue: 0.99630481, alpha: 1).cgColor, #colorLiteral(red: 0.9804552197, green: 0.8359815478, blue: 0.9779635072, alpha: 1).cgColor, #colorLiteral(red: 0.9792258143, green: 0.6606447101, blue: 0.681139946, alpha: 1).cgColor, #colorLiteral(red: 0.7292762399, green: 0.6618252397, blue: 0.8362961411, alpha: 1).cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    
        textView.textContainer.lineFragmentPadding = 0
        
        titleTextField.text = entry.title
        textView.text = entry.text
        if let mood = entry.mood {
            moodImageView.image = UIImage(named: mood)
            moodImageView.alpha = 1.0
        } else {
            moodImageView.image = UIImage(systemName: "plus.circle")
            moodImageView.alpha = 0.3
        }
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving entry: \(error.localizedDescription)")
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Delete Entry?", message: "This entry will be permanently deleted.", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.context.delete(self.entry)
            self.saveData()
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        entry.title = titleTextField.text
        saveData()
    }
}

//MARK: - UITextViewDelegate

extension DetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        entry.text = textView.text
        saveData()
    }
}
