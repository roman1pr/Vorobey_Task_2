//
//  AdaptiveButton.swift
//  Vorobey_Task_2
//
//  Created by Roman Priiskalov on 06.09.2023.
//

import UIKit
import Foundation

class TouchableButton: UIButton {
    
    private var animatorCollapse: UIViewPropertyAnimator?
    private var animatorGrow: UIViewPropertyAnimator?
    
    private let animationDuration: CGFloat = 0.2
    private let animationTransformScaleFactor: CGFloat = 0.85
    private var originalTransform: CGAffineTransform = .identity
    
    private var isToggled = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        originalTransform = transform
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()

        toggleColors()
    }
    
    private func toggleColors() {
        self.backgroundColor = isToggled ? .systemBlue : .systemGray2
        self.titleLabel?.textColor = isToggled ? .white :  .systemGray3
        self.imageView?.tintColor = isToggled ? .white : .systemGray3
        
        isToggled.toggle()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        // Прервать текущую анимацию, если такая есть
        animatorGrow?.stopAnimation(true)
        animatorCollapse?.stopAnimation(true)
        
        // Создать новый аниматор и настроить его
        animatorCollapse = UIViewPropertyAnimator(duration: animationDuration, curve: .linear) { [weak self] in
            guard let self else { return }
            self.transform = self.transform.scaledBy(x: self.animationTransformScaleFactor, y: self.animationTransformScaleFactor)
        }
        
        // Начать анимацию
        animatorCollapse?.startAnimation()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        // Прервать текущую анимацию и завершить ее
        animatorCollapse?.stopAnimation(true)
        animatorCollapse?.finishAnimation(at: .current)
        
        animatorGrow = UIViewPropertyAnimator(duration: animationDuration, curve: .linear) {
            self.transform = self.originalTransform
        }
        
        animatorGrow?.startAnimation()
        
    }
}
