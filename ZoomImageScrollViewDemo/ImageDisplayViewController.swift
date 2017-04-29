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
  
  override func viewWillAppear(_ animated: Bool) {
    
    statusBarHidden = true
    setNeedsStatusBarAppearanceUpdate()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override var prefersStatusBarHidden : Bool {
    return statusBarHidden
  }
  
  func onClickPhoto() {
    
    dismiss(animated: false, completion: nil)
  }
  
  func setupUI() {
    
    zoomImageScrollView = ZoomImageScrollView(image: image, frame: view.bounds)
    zoomImageScrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    view.addSubview(zoomImageScrollView)
    zoomImageScrollView.addImageTarget(self, action: #selector(ImageDisplayViewController.onClickPhoto))
    
    view.backgroundColor = UIColor.green
    
    //红点是中点，同时也始终在双击放大是点击的位置（如果图片没超过边界的话）
    let testView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 3, height: 3)))
    testView.isUserInteractionEnabled = false
    testView.center = CGPoint(x: view.frame.midX, y: view.frame.midY)
    testView.backgroundColor = UIColor.red
    view.addSubview(testView)
  }
  
  
  
}
