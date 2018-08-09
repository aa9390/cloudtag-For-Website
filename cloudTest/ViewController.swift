//
//  ViewController.swift
//  cloudTest
//
//  Created by soyeonKim on 2018. 8. 7..
//  Copyright © 2018년 ksy. All rights reserved.
//

import UIKit
import DBSphereTagCloudSwift

class ViewController: UIViewController {
    @IBOutlet weak var tagView: DBSphereView!
    var projectView: DBSphereView!
    var timer: CADisplayLink!
    var tagAndProjectDic:[String:[String]]
        = ["과일":["사과", "배", "복숭아", "딸기"], "동물":["코끼리", "강아지"], "감정":["기쁨", "슬픔", "분노"], "교통수단":["자동차", "자전거", "비행기"], "계절":["봄", "여름", "가을" ,"겨울"]]
    var isClicked:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        timer  = CADisplayLink(target: self, selector:)
//        timer.add(to: .main, forMode: .defaultRunLoopMode)
        
//        var tagArray = tagAndProjectDic.keys
        
        tagView = DBSphereView(frame: CGRect(x: -200, y: -200, width: 1000, height: 1000))
        let array = NSMutableArray(capacity: 0)
        
        for (key, value) in tagAndProjectDic {
            let btn: UIButton = UIButton(type: .custom)
            btn.setTitle(key, for: UIControlState())
            btn.setTitleColor(UIColor.black, for: .normal);
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0 , bottom: 0, right: 0)
            btn.setBackgroundImage(UIImage(named:"img_cloud_1"), for: UIControlState())
            btn.frame = CGRect(x: 0, y: 0, width: 250, height: 150)
            btn.layer.masksToBounds = true
            btn.contentMode = UIViewContentMode.scaleAspectFit
            btn.addTarget(self, action: #selector(ViewController.tagPressed(_:)), for: UIControlEvents.touchUpInside)
            array.add(btn)
            tagView.addSubview(btn)
        }

        tagView.setCloudTags((array as AnyObject) as! [UIView])
        self.view.addSubview(tagView)
    }
    
    
    @objc func tagPressed(_ btn: UIButton) {
        let projectArray = tagAndProjectDic[(btn.titleLabel?.text)!]!
//        timer.isPaused = true
//        tagView.timerStop()
        
        // 프로젝트 나오는 부분
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            btn.transform = CGAffineTransform(scaleX: 3, y: 3)
            
            // 클릭한 버튼을 중심으로 view가 새로 생성됨
            self.projectView = DBSphereView(frame: CGRect(x: (btn.frame.origin.x), y: (btn.frame.origin.y), width: 100, height: 100))

            let array = NSMutableArray(capacity: 0)

            print(projectArray)
            
            // 프로젝트명 가져오기
            for i in 0 ..< projectArray.count {
                let btn: UIButton = UIButton(type: UIButtonType.system)
                btn.setTitle(projectArray[i], for: UIControlState())
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                btn.titleLabel?.sizeToFit()
                btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0 , bottom: -10, right: 0)
                btn.layer.masksToBounds = true
                btn.setBackgroundImage(UIImage(named: "img_cloud_2"), for: UIControlState())
                btn.contentMode = UIViewContentMode.scaleAspectFit
                btn.frame = CGRect(x: 0, y: 0, width: 120, height: 70)
                btn.layer.cornerRadius = 0
                btn.addTarget(self, action: #selector(ViewController.projectPressed(_:)), for: UIControlEvents.touchUpInside)
                array.add(btn)
                self.projectView.addSubview(btn)
            }
            self.projectView.setCloudTags((array as AnyObject) as! [UIView])
            //            self.sphereView.backgroundColor =  UIColor(red:0/255, green: 210/255, blue: 240/255, alpha: 0.2)
            self.view.addSubview(self.projectView)
            self.view.bringSubview(toFront: self.projectView)

            let gesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.someAction(_:)))
            self.tagView.addGestureRecognizer(gesture)
        }) {
            (finished) -> Void in UIView.animate(withDuration: 0.3, animations: {() -> Void in
                btn.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { (finished) -> Void in
//                self.projectView.timerStart()
            })
        }
    }
    
    
    @objc func someAction(_ sender:UITapGestureRecognizer){
            self.projectView.isHidden = true
        
    }
    
    
    // 프로젝트 선택 시
    // 해당 프로젝트로 이동해야함
    @objc func projectPressed(_ btn: UIButton) {
//        let storyboard: UIStoryboard = UIStoryboard(name: "Collection", bundle: nil)
//        let nextView = storyboard.instantiateViewController(withIdentifier: "ProjectView") as! CollectionTableViewController
//        nextView.modelProject2 = modelProject.searchProjectOfTitle(title: (btn.titleLabel?.text)!)
//        self.navigationController?.pushViewController(nextView, animated: true)
//        //        self.present(nextView!, animated: true, completion: nil)
//
//        print("\(String(describing: btn.titleLabel!.text))프로젝트 선택됨")
//        self.sphereView.isHidden = true
//        self.sphereView.timerStop()
    }
}
