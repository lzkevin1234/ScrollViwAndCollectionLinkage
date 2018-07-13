//
//  TopScrollView.swift
//  ScrollWithCollectionView
//
//  Created by 刘泽 on 2018/7/12.
//  Copyright © 2018年 liuze. All rights reserved.
//

import UIKit
protocol TopScrollViewDelegate: class {
    /// 编辑按钮点击
    func channelButtonClicked(tage:NSInteger)
}
class TopScrollView: UIScrollView {
    weak var dele: TopScrollViewDelegate?
    var selectBtn:UIButton?
    let width = 60
    let screenW = UIScreen.main.bounds.size.width
    var buttonArr:[UIButton]
    
    
    init(frame: CGRect,titles:NSArray){
        buttonArr = NSMutableArray.init(capacity: 20) as! [UIButton]
        super.init(frame: frame)
//        buttonArr = NSMutableArray.init(capacity: 20) as! [UIButton]
        showsHorizontalScrollIndicator=false
        bounces = false
        setUpUI(frame: frame, titles: titles)
        
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func setUpUI(frame: CGRect,titles:NSArray) {

        for i in 0..<titles.count {
            let btn = UIButton.init(frame: CGRect(x:width*i, y: 0, width:width, height: Int(frame.size.height)))
            addSubview(btn)
            btn.tag = i
            btn.setTitle(titles[i] as? String, for: .normal)
            btn.addTarget(self, action: #selector(clickEvent), for: .touchUpInside)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            contentSize = CGSize(width:CGFloat(width*titles.count), height:frame.size.height)
            if i==0 {
                btn.setTitleColor(UIColor.red, for: .normal)
                selectBtn=btn
            }
            buttonArr.append(btn)
        }
    }
    
    @objc func clickEvent(btn:UIButton){
        if selectBtn==btn {
            return
        }
       
        selectBtn?.setTitleColor(UIColor.black, for: .normal)
         btn.setTitleColor(UIColor.red, for: .normal)
        selectBtn=btn
        let offset = CGFloat(btn.tag*width+width/2)
        if offset<=screenW/2 {
           setContentOffset(CGPoint(x:0, y: 0), animated: true)
            
        } else if offset>screenW/2 && contentSize.width-offset>screenW/2{
            setContentOffset(CGPoint(x:offset-screenW/2, y: 0), animated: true)
        } else {
            setContentOffset(CGPoint(x:contentSize.width-screenW, y: 0), animated: true)
        }
        if (dele != nil) {
            dele?.channelButtonClicked(tage: btn.tag)
        }
    }
    public func changeContentOffSet(tage:NSInteger){
        if selectBtn?.tag == tage {
            return
        }
        
        
        
        selectBtn?.setTitleColor(UIColor.black, for: .normal)
        buttonArr[tage].setTitleColor(UIColor.red, for: .normal)
     
        selectBtn = buttonArr[tage]
        let offset = CGFloat( buttonArr[tage].tag*width+width/2)
        if offset<=screenW/2 {
            setContentOffset(CGPoint(x:0, y: 0), animated: true)
            
        } else if offset>screenW/2 && contentSize.width-offset>screenW/2{
            setContentOffset(CGPoint(x:offset-screenW/2, y: 0), animated: true)
        } else {
            setContentOffset(CGPoint(x:contentSize.width-screenW, y: 0), animated: true)
        }
    }
}
