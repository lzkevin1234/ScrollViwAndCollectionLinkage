//
//  TempViewController.swift
//  ScrollWithCollectionView
//
//  Created by 刘泽 on 2018/7/12.
//  Copyright © 2018年 liuze. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {

   public var lab:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        lab = UILabel(frame:CGRect(origin: view.center, size: CGSize(width: 100, height: 30)))
        lab?.center = view.center
        lab?.textColor = UIColor.black
        lab?.backgroundColor = UIColor.red
        lab?.textAlignment = .center
        view.addSubview(lab!)
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
