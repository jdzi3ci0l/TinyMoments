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
    @IBOutlet weak var moodChangeButton: UIButton!
    
    var moods = [
        (nil, "None"), ("😁", "Very Happy"), ("🙂", "Happy"), ("😎", "Cool"),
        ("🥳", "Party"), ("🥰", "Loved"), ("😡", "Angry"), ("😩", "Tired"), ("😔", "Sad"), ("😭", "Crying")
    ]
    
    var moodMenuItems: [UIAction] {
        var items = [UIAction]()
        for mood in moods {
            items.append(
                UIAction(title: "\(mood.0 ?? "") \(mood.1)", image: nil) {_ in
                    self.entry.mood = mood.0
                    self.moodChangeButton.setTitle(mood.0 ?? "😶", for: .normal)
                    self.moodChangeButton.setImage(mood.0 == nil ? UIImage(named: "plus.circle") : nil, for: .normal)
                    self.moodChangeButton.alpha = mood.0 != nil ? 1.0 : 0.2
                    self.saveData()
                })
        }
        return items
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        titleTextField.delegate = self
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [#colorLiteral(red: 0.8518229127, green: 0.8488650322, blue: 0.99630481, alpha: 1).cgColor, #colorLiteral(red: 0.9804552197, green: 0.8359815478, blue: 0.9779635072, alpha: 1).cgColor, #colorLiteral(red: 0.9792258143, green: 0.6606447101, blue: 0.681139946, alpha: 1).cgColor, #colorLiteral(red: 0.7292762399, green: 0.6618252397, blue: 0.8362961411, alpha: 1).cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        
        textView.textContainer.lineFragmentPadding = 0
        
        titleTextField.text = entry.title
        textView.text = entry.text
        
        moodChangeButton.imageView?.tintColor = #colorLiteral(red: 0.486708045, green: 0.4391390383, blue: 0.5955944061, alpha: 1)
        moodChangeButton.menu = UIMenu(title: "Change mood", image: nil, identifier: nil, options: [], children: moodMenuItems)
        moodChangeButton.setTitle(entry.mood ?? "😶", for: .normal)
        moodChangeButton.alpha = entry.mood == nil ? 0.3 : 1.0
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving entry: \(error.localizedDescription)")
        }
    }
    
    @IBAction func rightUIBarButtonPressed(_ sender: UIBarButtonItem) {
        if textView.isFirstResponder || titleTextField.isFirstResponder {
            textView.endEditing(true)
            titleTextField.endEditing(true)
        } else {
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
    }
    
    func updateRightBarButtonItem(isCurrentlyEditing: Bool) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: isCurrentlyEditing ? .done : .trash,
            target: self,
            action: #selector(rightUIBarButtonPressed)
        )
        navigationItem.rightBarButtonItem?.tintColor = isCurrentlyEditing ? #colorLiteral(red: 0.486708045, green: 0.4391390383, blue: 0.5955944061, alpha: 1) : .red
    }
}

//MARK: - UITextViewDelegate methods

extension DetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        entry.text = textView.text
        saveData()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        updateRightBarButtonItem(isCurrentlyEditing: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updateRightBarButtonItem(isCurrentlyEditing: false)
    }
}


//MARK: - UITextFieldDelegate methods

extension DetailViewController: UITextFieldDelegate {
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        entry.title = titleTextField.text
        saveData()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateRightBarButtonItem(isCurrentlyEditing: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateRightBarButtonItem(isCurrentlyEditing: false)
    }
}
