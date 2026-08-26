-- chunkname: @modules/logic/versionactivity2_5/goldenmilletpresent/view/V2a5_GoldenMilletPresentViewContainer.lua

module("modules.logic.versionactivity2_5.goldenmilletpresent.view.V2a5_GoldenMilletPresentViewContainer", package.seeall)

local V2a5_GoldenMilletPresentViewContainer = class("V2a5_GoldenMilletPresentViewContainer", BaseViewContainer)

V2a5_GoldenMilletPresentViewContainer.ExclusiveView = {
	DisplayView = 2,
	ReceiveView = 1
}

function V2a5_GoldenMilletPresentViewContainer:buildViews()
	self.goldenMilletPresentView = V2a5_GoldenMilletPresentView.New()

	return {
		self.goldenMilletPresentView
	}
end

function V2a5_GoldenMilletPresentViewContainer:openGoldMilletPresentDisplayView()
	self.goldenMilletPresentView:switchExclusiveView(true)
end

return V2a5_GoldenMilletPresentViewContainer
