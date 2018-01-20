//
//  DidStoreLeftCenterLayoutProperty.swift
//  NotAutoLayout
//
//  Created by 史翔新 on 2017/06/20.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct DidStoreLeftCenterLayoutProperty {
		
	let left: LayoutElement.Horizontal
	
	let center: LayoutElement.Horizontal
	
}

// MARK: - Set A Line -
// MARK: Top
extension DidStoreLeftCenterLayoutProperty: LayoutPropertyCanStoreTopType {
	
	public typealias WillSetTopProperty = DidStoreLeftCenterTopLayoutProperty
	
	public func storeTop(_ top: LayoutElement.Vertical, to maker: LayoutMaker<DidStoreLeftCenterLayoutProperty>) -> LayoutMaker<DidStoreLeftCenterTopLayoutProperty> {
		
		let leftCenterTop = DidStoreLeftCenterTopLayoutProperty(left: self.left,
																center: self.center,
																top: top)
		let maker = LayoutMaker(parentView: maker.parentView,
								didSetProperty: leftCenterTop)
		
		return maker
		
	}
	
}

// MARK: Middle
extension DidStoreLeftCenterLayoutProperty: LayoutPropertyCanStoreMiddleType {
	
	public typealias WillSetMiddleProperty = DidStoreLeftCenterMiddleLayoutProperty
	
	public func storeMiddle(_ middle: LayoutElement.Vertical, to maker: LayoutMaker<DidStoreLeftCenterLayoutProperty>) -> LayoutMaker<DidStoreLeftCenterMiddleLayoutProperty> {
		
		let leftCenterMiddle = DidStoreLeftCenterMiddleLayoutProperty(left: self.left,
																	  center: self.center,
																	  middle: middle)
		let maker = LayoutMaker(parentView: maker.parentView,
								didSetProperty: leftCenterMiddle)
		
		return maker
		
	}
	
}

// MARK: Bottom
extension DidStoreLeftCenterLayoutProperty: LayoutPropertyCanStoreBottomType {
	
	public typealias WillSetBottomProperty = DidStoreLeftCenterBottomLayoutProperty
	
	public func storeBottom(_ bottom: LayoutElement.Vertical, to maker: LayoutMaker<DidStoreLeftCenterLayoutProperty>) -> LayoutMaker<DidStoreLeftCenterBottomLayoutProperty> {
		
		let leftCenterBottom = DidStoreLeftCenterBottomLayoutProperty(left: self.left,
																	  center: self.center,
																	  bottom: bottom)
		let maker = LayoutMaker(parentView: maker.parentView,
								didSetProperty: leftCenterBottom)
		
		return maker
		
	}
	
}
