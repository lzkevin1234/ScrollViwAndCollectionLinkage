//
//  ViewController.swift
//  ScrollWithCollectionView
//
//  Created by 刘泽 on 2018/7/12.
//  Copyright © 2018年 liuze. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,TopScrollViewDelegate {
   
   let screenW = UIScreen.main.bounds.size.width
   let screenH = UIScreen.main.bounds.size.height
   var collectionView:UICollectionView?
   let cellId = "test"
    var topView:TopScrollView?
    
   let titesArr:NSArray = ["Objective-C","安卓","java","phtyon","js","html","css","c语言","C++","php","go语言","C#","swift","javaScript","Ruby"]
    var childCVArr:NSArray {
        get{
            let arr = NSMutableArray.init(capacity: 20)
            for i in 0..<titesArr.count {
                let vc = TempViewController()

                vc.view.backgroundColor = UIColor.white

                vc.lab?.text=titesArr[i] as? String
                self.addChildViewController(vc)
                arr.add(vc)
            }
            
            return arr
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let topV = TopScrollView.init(frame: CGRect(x: 0, y: 0, width: screenW, height: 40), titles:titesArr)
        topV.dele = self
        topView = topV
   
        view.addSubview(topV)
        topV.backgroundColor=UIColor(named: "#DDDDDD")
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: screenW, height: screenH-40.0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionV = UICollectionView(frame: CGRect(x: 0, y: 40, width: screenW, height: screenH-40), collectionViewLayout: layout)
        view.addSubview(collectionV)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.isPagingEnabled = true
        collectionV.bounces = false
        collectionV.backgroundColor = UIColor.white
        collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier:cellId)
        collectionView = collectionV
    }

}

extension ViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childCVArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellId, for: indexPath)
        for v in cell.subviews {
            v.removeFromSuperview()
        }
        cell.addSubview((childCVArr[indexPath.row] as! UIViewController).view)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x/screenW
        topView?.changeContentOffSet(tage:NSInteger(offsetX))
    }
    func channelButtonClicked(tage: NSInteger) {
        collectionView?.setContentOffset(CGPoint(x: CGFloat(tage)*screenW, y: 0), animated: false)
    }
    
}
