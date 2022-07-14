//
//  UIScrollView+.swift
//  MVVMWithClosures
//
//  Created by Marcelo Fernandez on 13/07/2022.
//

import Foundation
import UIKit

extension UIScrollView {
    // TODO: Needs improvement
    func resizeScrollViewContentSize() {
        var scrollViewHeight: CGFloat = 0.0
        for view in self.subviews {
            scrollViewHeight += view.frame.height
        }
        self.contentSize.height += scrollViewHeight
    }
}
