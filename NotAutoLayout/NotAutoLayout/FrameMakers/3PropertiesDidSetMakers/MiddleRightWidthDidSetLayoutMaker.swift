//
//  MiddleRightWidthDidSetLayoutMaker.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct MiddleRightWidthDidSetLayoutMaker {
	
	public unowned let parentView: UIView
	
	let middleRight: CGRect.Point
	
	let width: CGRect.Float
	
}

extension MiddleRightWidthDidSetLayoutMaker {
	
	private func makeFrame(middleRight: CGPoint, width: CGFloat, height: CGFloat) -> CGRect {
		
		let x = middleRight.x - width
		let y = middleRight.y - height.half
		let size = CGSize(width: width, height: height)
		let origin = CGPoint(x: x, y: y)
		let frame = CGRect(origin: origin, size: size)
		
		return frame
		
	}
	
}

extension MiddleRightWidthDidSetLayoutMaker {
	
	public func setHeight(to height: CGFloat) -> Layout.Individual {
		
		if let middleRight = self.middleRight.constantValue, let width = self.width.constantValue {
			let frame = self.makeFrame(middleRight: middleRight, width: width, height: height)
			let layout = Layout.Individual.makeAbsolute(frame: frame)
			
			return layout
			
		} else {
			let layout = Layout.Individual.makeCustom { (boundSize) -> CGRect in
				let middleRight = self.middleRight.closureValue(boundSize)
				let width = self.width.closureValue(boundSize)
				let frame = self.makeFrame(middleRight: middleRight, width: width, height: height)
				
				return frame
				
			}
			
			return layout
			
		}
		
	}
	
	public func calculateHeight(by calculation: @escaping (_ boundSize: CGSize) -> CGFloat) -> Layout.Individual {
		
		let layout = Layout.Individual.makeCustom { (boundSize) -> CGRect in
			let middleRight = self.middleRight.closureValue(boundSize)
			let width = self.width.closureValue(boundSize)
			let height = calculation(boundSize)
			let frame = self.makeFrame(middleRight: middleRight, width: width, height: height)
			
			return frame
			
		}
		
		return layout
		
	}
	
}
