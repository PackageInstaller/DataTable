-- chunkname: @modules/logic/versionactivity2_5/goldenmilletpresent/view/V2a5_GoldenMilletPresentFullViewContainer.lua

module("modules.logic.versionactivity2_5.goldenmilletpresent.view.V2a5_GoldenMilletPresentFullViewContainer", package.seeall)

local V2a5_GoldenMilletPresentFullViewContainer = class("V2a5_GoldenMilletPresentFullViewContainer", BaseViewContainer)

V2a5_GoldenMilletPresentFullViewContainer.ExclusiveView = {
	DisplayView = 2,
	ReceiveView = 1
}

function V2a5_GoldenMilletPresentFullViewContainer:buildViews()
	self.goldenMilletPresentView = V2a5_GoldenMilletPresentFullView.New()

	return {
		self.goldenMilletPresentView
	}
end

function V2a5_GoldenMilletPresentFullViewContainer:openGoldMilletPresentDisplayView()
	self.goldenMilletPresentView:switchExclusiveView(true)
end

return V2a5_GoldenMilletPresentFullViewContainer
