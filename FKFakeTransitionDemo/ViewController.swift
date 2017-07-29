//
//  ViewController.swift
//  FKFakeTransition
//
//  Created by FlyKite on 2017/7/28.
//  Copyright © 2017年 FlyKite. All rights reserved.
//

import UIKit

enum TransitionType: String {
    case paperFolding = "Paper Folding"
}

class ViewController: UITableViewController, UINavigationControllerDelegate {
    
    let types: [TransitionType] = [.paperFolding]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return PaperFoldingTransition(seperateBy: 50 + 64)
        }
        return nil
    }

}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = types[indexPath.row].rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ExampleViewController1()
        let transition = self.createTransition(self.types[indexPath.row]) as! FKPaperFoldingTransitioning
        transition.foldingFromY = 50 + 64
        transition.prepareFakeTransitioning()
        controller.transition = transition
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    func createTransition(_ type: TransitionType) -> FKFakeTransitioning {
        switch type {
        case .paperFolding:
            return FKPaperFoldingTransition.create(with: APP.window!)
        }
    }
    
}
