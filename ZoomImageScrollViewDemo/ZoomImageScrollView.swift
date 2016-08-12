//
//  ZoomImageScrollView.swift
//  ZoomImageScrollViewDemo
//
//  Created by 范祎楠 on 16/8/5.
//  Copyright © 2016年 范祎楠. All rights reserved.
//

import UIKit

class ZoomImageScrollView: UIScrollView {

  private var image: UIImage
  
  private var imageView: UIImageView!
  private var singleTap: UITapGestureRecognizer!
  private var doubleTap: UITapGestureRecognizer!
  
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

  func addImageTarget(target: AnyObject, action: Selector) {
    singleTap.addTarget(target, action: action)
  }
  
  func imageViewDoubleTap(tap: UITapGestureRecognizer) {
  
    guard zoomScale == minimumZoomScale else {
      setZoomScale(minimumZoomScale, animated: true)
      return
    }
    
    let position = tap.locationInView(imageView)
    
    let zoomRectScale: CGFloat = 2
    
    let zoomWidth = (image.size.width + imageView.frame.minX * 2) / zoomRectScale
    let zoomHeight = (image.size.height + imageView.frame.minY * 2) / zoomRectScale
    
    let zoomX = position.x - zoomWidth / 2 - imageView.frame.minX / zoomRectScale
    let zoomY = position.y - zoomHeight / 2 - imageView.frame.minY / zoomRectScale
    
    let zoomRect = CGRect(x: zoomX, y: zoomY, width: zoomWidth, height: zoomHeight)
    zoomToRect(zoomRect, animated: true)
    
  }
  
  private func setupUI() {
    
    scrollEnabled = false
    backgroundColor = UIColor.blackColor()
    singleTap = UITapGestureRecognizer()
    addGestureRecognizer(singleTap)
    
    imageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: image.size))
    imageView.image = image
    addSubview(imageView)
    
    doubleTap = UITapGestureRecognizer(target: self, action: #selector(ZoomImageScrollView.imageViewDoubleTap(_:)))
    imageView.userInteractionEnabled = true
    imageView.addGestureRecognizer(doubleTap)

    doubleTap.numberOfTapsRequired = 2
    singleTap.requireGestureRecognizerToFail(doubleTap)
    
    calculateZoomScale()
  }
  
  private func calculateZoomScale() {
    
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
  
  private func moveFrameToCenter() {
    
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
  
  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return imageView
  }
  
  func scrollViewDidZoom(scrollView: UIScrollView) {
    setNeedsLayout()
    layoutIfNeeded()
  }
  
  func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
    scrollEnabled = true
  }
}
