//
//  QuoteTableViewCell.swift
//  quoteboard
//
//  Created by Matthew Siu on 28/6/2022.
//

import UIKit

protocol QuoteTableViewCellDelegate{
    func saveQuote(sentence: String, at indexPath: IndexPath)
}

class QuoteTableViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    
    var sentence: String = ""
    var indexPath: IndexPath = .init()
    var delegate: QuoteTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textView.isEditable = false
        self.saveBtn.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        // make sure scroll is disabled
        textView.isScrollEnabled = false
        // make sure delegate is set
        textView.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
//        let str = textView.text ?? ""
    }
    
    func setText(sentence: String, indexPath: IndexPath){
        self.indexPath = indexPath
        self.sentence = sentence
        self.textView.text = sentence
    }
    
    func enableEdit(enable: Bool = true){
        self.textView.isEditable = enable
        self.saveBtn.isHidden = !enable
        if (enable){
            self.textView.becomeFirstResponder()
            
        }
        
    }
    
    @IBAction func saveBtnDidPress(_ sender: Any) {
        self.delegate?.saveQuote(sentence: self.textView.text, at: self.indexPath)
        self.enableEdit(enable: false)
    }
}
