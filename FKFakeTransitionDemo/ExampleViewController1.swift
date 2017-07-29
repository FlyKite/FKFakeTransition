//
//  ExampleViewController.swift
//  FKFakeTransition
//
//  Created by 风筝 on 2017/7/29.
//  Copyright © 2017年 FlyKite. All rights reserved.
//

import UIKit

class ExampleViewController1: UIViewController {
    
    var transition: FKFakeTransitioning?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let view = UIView()
        view.frame = CGRect(x: 100, y: 100, width: 100, height: 400)
        view.backgroundColor = UIColor.black
        self.view.addSubview(view)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        transition?.performFakeTransitioning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
