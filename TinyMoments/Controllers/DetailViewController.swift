//
//  DetailViewController.swift
//  TinyMoments
//
//  Created by Janusz on 09/04/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var entry: Entry? = nil
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var moodImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [#colorLiteral(red: 0.8518229127, green: 0.8488650322, blue: 0.99630481, alpha: 1).cgColor, #colorLiteral(red: 0.9804552197, green: 0.8359815478, blue: 0.9779635072, alpha: 1).cgColor, #colorLiteral(red: 0.9792258143, green: 0.6606447101, blue: 0.681139946, alpha: 1).cgColor, #colorLiteral(red: 0.7292762399, green: 0.6618252397, blue: 0.8362961411, alpha: 1).cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    
        textView.textContainer.lineFragmentPadding = 0
        
        titleTextField.text = entry?.title
        textView.text = entry?.text
        if let mood = entry?.mood {
            moodImageView.image = UIImage(named: mood)
        } else {
            moodImageView.image = nil
        }
    }
}


//MARK: - UITextFieldDelegate

extension DetailViewController: UITextFieldDelegate {
    
}

//MARK: - UITextViewDelegate

extension DetailViewController: UITextViewDelegate {
    
}
