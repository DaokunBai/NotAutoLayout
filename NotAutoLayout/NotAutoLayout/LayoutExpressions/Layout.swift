//
//  LayoutIndividual.swift
//  NotAutoLayout
//
//  Created by 史　翔新 on 2017/06/16.
//  Copyright © 2017年 史翔新. All rights reserved.
//

import Foundation

public struct Layout {
	
	@available(*, introduced: 2.0, deprecated: 2.1, renamed: "Layout", message: "Layout.Individual has been renamed to Layout, in addition sequential layout and matrical layout will have their own type names in future release, too.")
	public typealias Individual = Layout
	
	private var basicFrameEvaluation: Frame
	
	private var additionalEvaluations: [FrameAdditionalEvaluation]
	
	private init(frame: CGRect) {
		self.basicFrameEvaluation = Frame.constant(frame)
		self.additionalEvaluations = []
	}
	
	private init(evaluation: @escaping (_ parameter: LayoutControlParameter) -> CGRect) {
		self.basicFrameEvaluation = Frame.basicEvaluation(evaluation)
		self.additionalEvaluations = []
	}
	
	private init(evaluation: @escaping (_ fittedSize: (_ fittingSize: CGSize) -> CGSize, _ parameter: LayoutControlParameter) -> CGRect) {
		self.basicFrameEvaluation = Frame.fittingEvaluation(evaluation)
		self.additionalEvaluations = []
	}
	
	private init(x: @escaping (LayoutControlParameter) -> CGFloat, y: @escaping (LayoutControlParameter) -> CGFloat, width: @escaping (LayoutControlParameter) -> CGFloat, height: @escaping (LayoutControlParameter) -> CGFloat) {
		
		let frame: (LayoutControlParameter) -> CGRect = { parameter in
			let frame = CGRect(x: x(parameter),
			                   y: y(parameter),
			                   width: width(parameter),
			                   height: height(parameter))
			return frame
		}
		
		self.basicFrameEvaluation = Frame.basicEvaluation(frame)
		self.additionalEvaluations = []
		
	}

}

extension Layout {
	
	static let dummy: Layout = Layout(frame: .zero)
	
}

extension Layout {
	
	static func makeAbsolute(frame: CGRect) -> Layout {
		let layout = Layout(frame: frame)
		return layout
	}
	
	static func makeCustom(x: @escaping (LayoutControlParameter) -> CGFloat, y: @escaping (LayoutControlParameter) -> CGFloat, width: @escaping (LayoutControlParameter) -> CGFloat, height: @escaping (LayoutControlParameter) -> CGFloat) -> Layout {
		let layout = Layout(x: x, y: y, width: width, height: height)
		return layout
	}
	
	static func makeCustom(frame: @escaping (LayoutControlParameter) -> CGRect) -> Layout {
		let layout = Layout(evaluation: frame)
		return layout
	}
	
	static func makeCustom(frame: @escaping (_ fittedSize: (_ fittingSize: CGSize) -> CGSize, _ parameter: LayoutControlParameter) -> CGRect) -> Layout {
		let layout = Layout(evaluation: frame)
		return layout
	}
	
}

extension Layout {
	
	var frameAdditionalEvaluations: [FrameAdditionalEvaluation] {
		return self.additionalEvaluations
	}
	
}

extension Layout {
	
	public func editing(_ editing: (LayoutEditor) -> LayoutEditor) -> Layout {
		
		let editor = LayoutEditor(self)
		let result = editing(editor).layout
		
		return result
		
	}
	
}

extension Layout {
	
	mutating func addAdditionalEvaluation(_ evaluation: FrameAdditionalEvaluation) {
		
		self.additionalEvaluations.append(evaluation)
		
	}
	
	mutating func setAdditionalEvaluations(_ evaluations: [FrameAdditionalEvaluation]) {
		
		self.additionalEvaluations = evaluations
		
	}
	
}

extension Layout {
	
	func evaluatedFrame(for view: UIView, with parameter: LayoutControlParameter) -> CGRect {
		
		var frame = self.basicFrameEvaluation.frame(fittedBy: { view.sizeThatFits($0) }, with: parameter)
		
		for evaluation in self.additionalEvaluations {
			frame = evaluation.evaluated(for: view, from: frame, with: parameter)
		}
		
		return frame
		
	}
	
}
