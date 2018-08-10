//
//  ViewController.swift
//  cloudTest
//
//  Created by soyeonKim on 2018. 8. 7..
//  Copyright © 2018년 ksy. All rights reserved.
//

import UIKit
import DBSphereTagCloudSwift

class MainViewController: UIViewController {
    var tagView: DBSphereView!
    var detailView: DBSphereView!
    var tagAndDetailDic:[String:[String]]
        = ["과일":["사과", "배", "복숭아", "딸기"], "동물":["코끼리", "강아지"], "감정":["기쁨", "슬픔", "분노"], "교통수단":["자동차", "자전거", "비행기"], "계절":["봄", "여름", "가을" ,"겨울"]]
    var isClicked:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagView = DBSphereView(frame: CGRect(x: -200, y: -200, width: 1000, height: 1000))
        let array = NSMutableArray(capacity: 0)
        
        for (key, value) in tagAndDetailDic {
            let btn: UIButton = UIButton(type: .custom)
            btn.setTitle(key, for: UIControlState())
            btn.setTitleColor(UIColor.black, for: .normal);
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0 , bottom: 0, right: 0)
            btn.setBackgroundImage(UIImage(named:"img_cloud_1"), for: UIControlState())
            btn.frame = CGRect(x: 0, y: 0, width: 250, height: 150)
            btn.layer.masksToBounds = true
            btn.contentMode = UIViewContentMode.scaleAspectFit
            btn.addTarget(self, action: #selector(MainViewController.tagPressed(_:)), for: UIControlEvents.touchUpInside)
            array.add(btn)
            tagView.addSubview(btn)
        }

        tagView.setCloudTags((array as AnyObject) as! [UIView])
        self.view.addSubview(tagView)
    }
    
    
    @objc func tagPressed(_ btn: UIButton) {
        let detailArray = tagAndDetailDic[(btn.titleLabel?.text)!]!
        tagView.timerStop()
        
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            btn.transform = CGAffineTransform(scaleX: 3, y: 3)
            
            // 클릭한 버튼을 중심으로 view가 새로 생성됨
            self.detailView = DBSphereView(frame: CGRect(x: (btn.frame.origin.x+100), y: (btn.frame.origin.y), width: 100, height: 100))

            let array = NSMutableArray(capacity: 0)

            print(detailArray)
            
            for i in 0 ..< detailArray.count {
                let btn: UIButton = UIButton(type: UIButtonType.system)
                btn.setTitle(detailArray[i], for: UIControlState())
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                btn.titleLabel?.sizeToFit()
                btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0 , bottom: -10, right: 0)
                btn.layer.masksToBounds = true
                btn.setBackgroundImage(UIImage(named: "img_cloud_2"), for: UIControlState())
                btn.contentMode = UIViewContentMode.scaleAspectFit
                btn.frame = CGRect(x: 0, y: 0, width: 120, height: 70)
                btn.layer.cornerRadius = 0
                btn.addTarget(self, action: #selector(MainViewController.detailPressed(_:)), for: UIControlEvents.touchUpInside)
                array.add(btn)
                self.detailView.addSubview(btn)
            }
            self.detailView.setCloudTags((array as AnyObject) as! [UIView])
            self.view.addSubview(self.detailView)
            self.view.bringSubview(toFront: self.detailView)

            let gesture = UITapGestureRecognizer(target: self, action: #selector(MainViewController.backgroundPressed(_:)))
            self.tagView.addGestureRecognizer(gesture)
        }) {
            (finished) -> Void in UIView.animate(withDuration: 0.3, animations: {() -> Void in
                btn.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { (finished) -> Void in
                self.detailView.timerStart()
            })
        }
    }
    
    
    @objc func backgroundPressed(_ sender:UITapGestureRecognizer){
            self.detailView.isHidden = true
        
    }
    
    
    // 프로젝트 선택 시
    // 해당 프로젝트로 이동해야함
    @objc func detailPressed(_ btn: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        nextView.labelText = btn.titleLabel?.text
        nextView.title = "Detail"
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}
