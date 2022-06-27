//
//  QuoteTableViewHeader.swift
//  quoteboard
//
//  Created by Matthew Siu on 28/6/2022.
//

import UIKit

protocol QuoteTableViewHeaderDelegate {
    func editSceneNameBtnDidPress(index: Int)
}

class QuoteTableViewHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var groupNameLabel: UILabel!
    var delegate: QuoteTableViewHeaderDelegate?
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setText(index: Int, name: String){
        self.groupNameLabel.text = name
        self.index = index
    }
    
    @IBAction func editBtnDidPress(_ sender: Any) {
        self.delegate?.editSceneNameBtnDidPress(index: self.index)
    }
    
}
