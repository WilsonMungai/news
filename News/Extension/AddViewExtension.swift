//
//  AddViewExtension.swift
//  News
//
//  Created by Wilson Mungai on 2023-04-16.
//

import Foundation
import UIKit

//Extension to modify apples default addSubView uiview
extension UIView
{
    // add subview
    func addSubviews(_ views: UIView...)
    {
        views.forEach({
            addSubview($0)
        })
    }
}
