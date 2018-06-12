//
//  ViewController.swift
//  AJBottomSheet
//
//  Created by alvinjohntandoc on 06/12/2018.
//  Copyright (c) 2018 alvinjohntandoc. All rights reserved.
//

import UIKit
import AJBottomSheet

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showListAction(_ sender: Any) {
        let vc: ListViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        
        AJBottomSheetViewController.show(viewController: vc, height: 300, source: self)
    }
}

