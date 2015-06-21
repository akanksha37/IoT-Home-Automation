//
//  NewAccount.swift
//  GarageOpener
//
//  Created by David Gatti on 6/13/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import Foundation
import UIKit
import Parse

class NewAccountViewController: UIViewController, UITextFieldDelegate {
    
    var tmpUserName: String?
    
    @IBOutlet weak var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        txtName.delegate = self;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.tmpUserName = textField.text
        
        self.performSegueWithIdentifier("takePhotho", sender: self)
        
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var desitnationView: AvatarViewController = segue.destinationViewController as! AvatarViewController
        
        desitnationView.userName = self.tmpUserName
    }
}