//
//  KeyboardViewController.swift
//  SocialKeyboard
//
//  Created by Matthew Siu on 21/5/2022.
//

import UIKit


class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    var vc: HomeViewController = HomeViewController()

    override func viewDidLoad() {
      super.viewDidLoad()
        
        self.vc = UIStoryboard(name: "HomeViewController", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        addChild(vc)
        self.view.addSubview(vc.view)
        vc.view.frame = view.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParent: self)
        vc.delegate = self
      
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)

        self.nextKeyboardButton.setTitle(NSLocalizedString("Chat is boring", comment: "Save your time on typing"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false

        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)

        self.view.addSubview(self.nextKeyboardButton)

        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
//        proxy.insertText("hello world")
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
        
        if let selectedText = textDocumentProxy.selectedText{
            print("selected text = \(selectedText)")
            self.vc.copySentence(sentence: selectedText)
        }
        
    }
    
}

extension KeyboardViewController{
    
}

extension KeyboardViewController: HomeViewDelegate{
    func selectSentence(sentence: String?) {
        if let sentence = sentence {
            self.textDocumentProxy.insertText(sentence)
        }
        
    }
    
    
}
