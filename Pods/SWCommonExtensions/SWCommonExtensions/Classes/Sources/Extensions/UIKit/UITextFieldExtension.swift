//
//  UITextFieldExtension.swift
//  SWExtensions
//
//  Created by Seven on 2019/6/17.
//  Copyright © 2019 CYCON.com. All rights reserved.
//

import UIKit

extension UITextField {
    public var length: Int { return text != nil ? text!.count : 0 }
    public var notNullText: String { return text ?? "" }
}

extension UITextField {
    public func clean() {
        self.text = nil
    }
}

// MARK: - Define
/** @enum ShakeDirection
 *
 * Enum that specifies the direction of the shake
 */
public enum UITextFieldShakeDirection {
    /** Shake left and right */
    case horizontal
    /** Shake up and down */
    case vertical
}

// MARK: - Public
/**
 * @name UITextField+Shake
 * A UITextField category that add the ability to shake the component
 */
extension UITextField {
    /** Shake the UITextField
     *
     * Shake the text field with default values
     */
    public func shake() {
        self.shake(times: 10, delta: 5, completionHandler: nil)
    }
    
    /** Shake the UITextField
     *
     * Shake the text field a given number of times
     *
     * @param times The number of shakes
     * @param delta The width of the shake
     */
    public func shake(times : Int, delta : CGFloat) {
        self.shake(times: times, delta: delta, completionHandler: nil)
    }
    
    /** Shake the UITextField
     *
     * Shake the text field a given number of times
     *
     * @param times The number of shakes
     * @param delta The width of the shake
     * @param handler A block object to be executed when the shake sequence ends
     */
    public func shake(times : Int, delta : CGFloat, completionHandler handler : (() -> Void)? = nil) {
        self.pShake(currentTimes: 0, andDirection: 1, andTimes: times, withDelta: delta, andSpeed: 0.03, andShakeDirection: .horizontal, andCompletionHandler: handler)
    }
    
    /** Shake the UITextField at a custom speed
     *
     * Shake the text field a given number of times with a given speed
     *
     * @param times The number of shakes
     * @param delta The width of the shake
     * @param interval The duration of one shake
     */
    public func shake(times : Int, delta : CGFloat, speed interval : TimeInterval) {
        self.shake(times: times, delta: delta, speed: interval, completionHandler: nil)
    }
    
    /** Shake the UITextField at a custom speed
     *
     * Shake the text field a given number of times with a given speed
     *
     * @param times The number of shakes
     * @param delta The width of the shake
     * @param interval The duration of one shake
     * @param handler A block object to be executed when the shake sequence ends
     */
    public func shake(times : Int, delta : CGFloat, speed interval : TimeInterval, completionHandler handler : (() -> Void)?) {
        self.pShake(currentTimes: 0, andDirection: 1, andTimes: times, withDelta: delta, andSpeed: interval, andShakeDirection: .horizontal, andCompletionHandler: handler)
    }
    
    /** Shake the UITextField at a custom speed
     *
     * Shake the text field a given number of times with a given speed
     *
     * @param times The number of shakes
     * @param delta The width of the shake
     * @param interval The duration of one shake
     * @param direction of the shake
     */
    public func shake(times : Int, delta : CGFloat, speed interval : TimeInterval, shakeDirection : UITextFieldShakeDirection = .horizontal) {
        self.shake(times: times, delta: delta, speed: interval, shakeDirection: shakeDirection, completionHandler: nil)
    }
    
    /** Shake the UITextField at a custom speed
     *
     * Shake the text field a given number of times with a given speed
     *
     * @param times The number of shakes
     * @param delta The width of the shake
     * @param interval The duration of one shake
     * @param direction of the shake
     * @param handler A block object to be executed when the shake sequence ends
     */
    public func shake(times : Int, delta : CGFloat, speed interval : TimeInterval, shakeDirection : UITextFieldShakeDirection, completionHandler handler : (() -> Void)?) {
        self.pShake(currentTimes: 0, andDirection: 1, andTimes: times, withDelta: delta, andSpeed: interval, andShakeDirection: shakeDirection, andCompletionHandler: handler)
    }
    
}

// MARK: - Private
private extension UITextField {
    func pShake(currentTimes current : Int, andDirection direction : Int, andTimes times : Int, withDelta delta : CGFloat, andSpeed interval : TimeInterval, andShakeDirection shakeDirection : UITextFieldShakeDirection, andCompletionHandler handler : (() -> Void)?) {
        UIView.animate(
            withDuration: interval,
            animations: {
                self.transform = shakeDirection == .horizontal ? CGAffineTransform(translationX: delta * direction.cgfloat, y: 0) : CGAffineTransform(translationX: 0, y: delta * direction.cgfloat)
        }
        ) { (finished) in
            
            if current >= times {
                UIView.animate(
                    withDuration: interval,
                    animations: {
                        self.transform = .identity
                },
                    completion: { (finished) in
                        handler?()
                }
                )
                return
            }
            
            self.pShake(currentTimes: current + 1, andDirection: direction * -1, andTimes: times - 1, withDelta: delta, andSpeed: interval, andShakeDirection: shakeDirection, andCompletionHandler: handler)
        }
    }
}
