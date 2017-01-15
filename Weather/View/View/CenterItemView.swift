//
//  CenterItemView.swift
//  Weather
//
//  Created by Dmitriy Shulzhenko on 1/11/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class CenterItemView: UIView, ViewProtocol {

    let label = UILabel()
    @IBInspectable var textColor: UIColor = UIColor.gray
    @IBInspectable var textHighlightedColor: UIColor = UIColor.white
    @IBInspectable var textSelectedColor: UIColor = UIColor.white

    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.white
    @IBInspectable var borderHighlightedColor: UIColor = UIColor.gray
    @IBInspectable var borderSelectedColor: UIColor = UIColor.gray
    
    @IBInspectable var centerViewColor: UIColor = UIColor.white
    @IBInspectable var centerViewHighlightedColor: UIColor = UIColor.gray
    @IBInspectable var centerViewSelectedColor: UIColor = UIColor.gray
    
    var presenter: ViewPresenterProtocol!
    
    var shouldAutomaticlySelect: Bool = true
    
    var viewTapped: ((_ sender: Any)->Void)?
    
    private let centerView = UIView()
    private var tapRecognizer: UITapGestureRecognizer!
    
    var isHighlighted: Bool = false {
        didSet {
            if isHighlighted {
                
            } else {
                
            }
        }
    }
    
    var isSelected: Bool = false {
        didSet {
            centerView.backgroundColor = isSelected ? borderSelectedColor : borderColor
            label.textColor = isSelected ? textSelectedColor : textColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    func defaultInit() {
        isSelected = false
        self.centerView.addSubview(self.label)
        self.addSubview(self.centerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        presenter.layoutSubviews()
        centerView.frame = CGRect(origin: CGPoint(x: borderWidth,
                                                  y: borderWidth),
                                  size: CGSize(width: frame.size.width - borderWidth,
                                               height: frame.size.height - borderWidth))
        centerView.layer.cornerRadius = centerView.frame.size.width / 2
        layer.cornerRadius = frame.size.width / 2
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        func addRecognizer() {
            self.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(_viewTapped(_:)))
            self.addGestureRecognizer(self.tapRecognizer)
        }
        
        if let recognizers = self.gestureRecognizers {
            if !recognizers.contains(self.tapRecognizer) {
                addRecognizer()
            }
        } else {
            addRecognizer()
        }
    }
    
    @objc private func _viewTapped(_ sender: Any) {
        if self.shouldAutomaticlySelect {
            isSelected = true
        }
        viewTapped?(sender)
    }
}
