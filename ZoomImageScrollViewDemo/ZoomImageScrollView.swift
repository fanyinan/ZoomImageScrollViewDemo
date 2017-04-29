//
//  ZoomImageScrollView.swift
//  ZoomImageScrollViewDemo
//
//  Created by 范祎楠 on 16/8/5.
//  Copyright © 2016年 范祎楠. All rights reserved.
//

import UIKit

class ZoomImageScrollView: UIScrollView {

  fileprivate var image: UIImage
  
  fileprivate var imageView: UIImageView!
  fileprivate var singleTap: UITapGestureRecognizer!
  fileprivate var doubleTap: UITapGestureRecognizer!
  
  init(image: UIImage, frame: CGRect) {
    
    self.image = image
    
    super.init(frame: frame)
    
    delegate = self
    
    setupUI()
  }
  
  override func layoutSubviews() {
    
    moveFrameToCenter()
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func addImageTarget(_ target: AnyObject, action: Selector) {
    singleTap.addTarget(target, action: action)
  }
  
  func imageViewDoubleTap(_ tap: UITapGestureRecognizer) {
  
    guard zoomScale == minimumZoomScale else {
      setZoomScale(minimumZoomScale, animated: true)
      return
    }
    
    let position = tap.location(in: imageView)
    
    let zoomRectScale: CGFloat = 2
    
    let zoomWidth = frame.width / zoomScale / zoomRectScale
    let zoomHeight = frame.height / zoomScale / zoomRectScale
    
    let zoomX = position.x - zoomWidth / 2 - imageView.frame.minX / zoomScale / zoomRectScale
    let zoomY = position.y - zoomHeight / 2 - imageView.frame.minY / zoomScale / zoomRectScale
    
    let zoomRect = CGRect(x: zoomX, y: zoomY, width: zoomWidth, height: zoomHeight)
    zoom(to: zoomRect, animated: true)
    
  }
  
  fileprivate func setupUI() {
    
    isScrollEnabled = false
    backgroundColor = UIColor.black
    singleTap = UITapGestureRecognizer()
    addGestureRecognizer(singleTap)
    
    imageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: image.size))
    imageView.image = image
    addSubview(imageView)
    
    doubleTap = UITapGestureRecognizer(target: self, action: #selector(ZoomImageScrollView.imageViewDoubleTap(_:)))
    imageView.isUserInteractionEnabled = true
    imageView.addGestureRecognizer(doubleTap)

    doubleTap.numberOfTapsRequired = 2
    singleTap.require(toFail: doubleTap)
    
    calculateZoomScale()
  }
  
  fileprivate func calculateZoomScale() {
    
    let boundSize = bounds.size
    let imageSize = image.size
    
    let scaleX = boundSize.width / imageSize.width
    let scaleY = boundSize.height / imageSize.height
    
    var minScale = min(scaleX, scaleY)
    
    if scaleX > 1 && scaleY > 1 {
      minScale = 1
    }
    
    minimumZoomScale = minScale
    zoomScale = minimumZoomScale
    maximumZoomScale = 3
    
  }
  
  fileprivate func moveFrameToCenter() {
    
    let boundsSize = bounds.size
    let imageViewSize = imageView.frame.size
    
    var adjustX: CGFloat = 0
    var adjustY: CGFloat = 0
    
    if boundsSize.width > imageViewSize.width {
      adjustX = (boundsSize.width - imageViewSize.width) / 2
    }
    
    if boundsSize.height > imageViewSize.height {
      adjustY = (boundsSize.height - imageViewSize.height) / 2
    }
    
    imageView.frame.origin = CGPoint(x: adjustX, y: adjustY)
    
  }
}

extension ZoomImageScrollView: UIScrollViewDelegate {
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
  
  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    setNeedsLayout()
    layoutIfNeeded()
  }
  
  func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
    isScrollEnabled = true
  }
}
