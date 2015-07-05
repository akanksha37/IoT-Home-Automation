//
//  ViewController.swift
//  GarageOpener
//
//  Created by David Gatti on 6/5/15.
//  Copyright (c) 2015 David Gatti. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            
            // First, lets check if Particle is connected.
            httpGet("") { (data, error) -> Void in
                
                if error == nil {
                    
                    // If we have the remote connected to the internets,
                    // then we can continue getting data and show the main interface.
                    if data["connected"] {
                        
                        var garageState = GarageState.sharedInstance
                        
                        // Retrive all the data from Parse and show the main interface
                        garageState.get({ (result) -> Void in
                            dispatch_async(dispatch_get_main_queue()) {
                                self.performSegueWithIdentifier("garageDoor", sender: self)
                            }
                        })
                        
                    }
                    else
                    {
                        dispatch_async(dispatch_get_main_queue()) {
                            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("errorView") as! UIViewController
                            self.presentViewController(vc, animated: true, completion: nil)
                        }
                    }
                }
                else
                {
                    println(error!.localizedDescription)
                }
            }
        }
        else
        {

            dispatch_async(dispatch_get_main_queue()) {

                self.performSegueWithIdentifier("decisionView", sender: self)
            }
        }
    }
}
