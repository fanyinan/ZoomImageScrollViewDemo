//
//  ImageDisplayViewController.swift
//  ZoomImageScrollViewDemo
//
//  Created by 范祎楠 on 16/8/5.
//  Copyright © 2016年 范祎楠. All rights reserved.
//

import UIKit

class ImageDisplayViewController: UIViewController {
  
  var image: UIImage
  
  var zoomImageScrollView: ZoomImageScrollView!
  var statusBarHidden = false
  
  init(image: UIImage) {
    self.image = image
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  override func viewWillAppear(animated: Bool) {
    
    statusBarHidden = true
    setNeedsStatusBarAppearanceUpdate()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return statusBarHidden
  }
  
  func onClickPhoto() {
    
    dismissViewControllerAnimated(false, completion: nil)
  }
  
  func setupUI() {
    
    zoomImageScrollView = ZoomImageScrollView(image: image, frame: view.bounds)
    zoomImageScrollView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
    view.addSubview(zoomImageScrollView)
    zoomImageScrollView.addImageTarget(self, action: #selector(ImageDisplayViewController.onClickPhoto))
    
    view.backgroundColor = UIColor.greenColor()
  }
  
  
  
}
