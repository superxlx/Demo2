//
//  ViewController.swift
//  Demo2
//
//  Created by xlx on 15/7/20.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HZPhotoBrowserDelegate,XActionSheetDelegate{

    var tableView:UITableView!
    var ObjectArray = [String]()
    var i = 0
    
    var head:XHPathCover!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.tableView = UITableView(frame: self.view.frame)
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        
        for i ; i < 10 ; i++ {
            self.ObjectArray.append("\(i)")
        }
        
    //    self.tableView.addLegendHeaderWithRefreshingTarget(self, refreshingAction: "headRefresh")
        self.tableView.addGifFooterWithRefreshingTarget(self, refreshingAction: "footRefresh")
        
        head = XHPathCover(frame: CGRectMake(0, 0, 320, 200))
        head.setBackgroundImage(UIImage(named: "BG"))
        head.setAvatarImage(UIImage(named: "cute_girl.jpg"))
        head.isZoomingEffect = true;
        head.setInfo(NSDictionary(objectsAndKeys: "StrongX",XHUserNameKey,"iOS工程师",XHBirthdayKey)as [NSObject:AnyObject])
        head.avatarButton.layer.cornerRadius = 33;
        head.avatarButton.layer.masksToBounds = true
        head.avatarButton.addTarget(self, action: "PhotoBrowser", forControlEvents: UIControlEvents.TouchUpInside)
        head.handleRefreshEvent = {
            self.headRefresh()
        }
        
        var Line = LineView(frame: CGRectMake(0, 200, 320, 60))
        
        var HeadView = UIView(frame: CGRectMake(0, 0, 320, 200 + 60))
        
        HeadView.addSubview(Line)
        HeadView.addSubview(head)
        
        tableView.tableHeaderView = HeadView
        
        head.sayHello()
        
        tableView.sayHello()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        head.scrollViewDidScroll(scrollView)
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        head.scrollViewDidEndDecelerating(scrollView)
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        head.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        head.scrollViewWillBeginDragging(scrollView)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ObjectArray.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        var image = UIImageView(frame: CGRectMake(10, 10, 60, 60))
        image.layer.cornerRadius = 30
        image.layer.masksToBounds = true
        image.sd_setImageWithURL(NSURL(string: "http://ac-hn8w3hlp.clouddn.com/fVju6pA4WGzVGNGsVdVXEzB.png"), placeholderImage: UIImage(named: "cute_girl.jpg"))
        cell.contentView.addSubview(image)
        
        var label = UILabel(frame: CGRectMake(80, 30, 100, 20))
        label.text = "这是第\(indexPath.row)行"
        cell.contentView.addSubview(label)
        
        
        
        return cell
    }
    func headRefresh(){
        ProgressHUD.show("亲爱的，别急嘛～～～")
        self.Delay(2, closure: { () -> () in
            self.ObjectArray.removeAll(keepCapacity: false)
            self.i = 0
            for self.i ; self.i < 10 ; self.i++ {
                self.ObjectArray.append("\(self.i)")
            }
       //     self.tableView.header.endRefreshing()
            self.tableView.reloadData()
            self.head.stopRefresh()
            ProgressHUD.showSuccess("人家准备好了！")
        })
    }
    func footRefresh(){
        ProgressHUD.show("还有更多内容")
        self.Delay(2, closure: { () -> () in
            var j = self.i + 10
            for self.i ; self.i < j ; self.i++ {
                self.ObjectArray.append("\(self.i)")
            }
            self.tableView.footer.endRefreshing()
            self.tableView.reloadData()
            ProgressHUD.showSuccess("好了啦～～")
        })
    }
    func Delay(time:Double,closure:()->()){
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
    
    func PhotoBrowser(){
        var action = XActionSheet()
        action.delegate = self
        action.addButtonwithTitle("拍照")
        action.addCancelButton("取消")
        action.addButtonwithTitle("相册")
        action.addButtonwithTitle("查看高清大图")
        self.presentViewController(action, animated: true) { () -> Void in
            
        }

    }
    func photoBrowser(browser: HZPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        return head.avatarButton.currentImage
    }
    func photoBrowser(browser: HZPhotoBrowser!, highQualityImageURLForIndex index: Int) -> NSURL! {
        var url = NSURL(string: "http://ac-hn8w3hlp.clouddn.com/dGWm2GEFNFoisI6beHBUQjD.png")
        return url
    }
    func buttonClick(index: Int) {
        println("\(index)")
        if(index == 2){
            var BrowserVC = HZPhotoBrowser()
            BrowserVC.sourceImagesContainerView = head.avatarButton
            BrowserVC.imageCount = 1
            BrowserVC.currentImageIndex = 0
            BrowserVC.delegate = self
            BrowserVC.show()

        }
    }
}

