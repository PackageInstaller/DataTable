-- chunkname: @modules/logic/versionactivity3_4/goldenmilletpresent/view/V3a4_GoldenMilletPresentViewContainer.lua

module("modules.logic.versionactivity3_4.goldenmilletpresent.view.V3a4_GoldenMilletPresentViewContainer", package.seeall)

local V3a4_GoldenMilletPresentViewContainer = class("V3a4_GoldenMilletPresentViewContainer", BaseViewContainer)

V3a4_GoldenMilletPresentViewContainer.ExclusiveView = {
	DisplayView = 2,
	ReceiveView = 1
}

function V3a4_GoldenMilletPresentViewContainer:buildViews()
	self.goldenMilletPresentView = V3a4_GoldenMilletPresentView.New()

	return {
		self.goldenMilletPresentView
	}
end

function V3a4_GoldenMilletPresentViewContainer:openGoldMilletPresentDisplayView()
	self.goldenMilletPresentView:switchExclusiveView(true)
end

return V3a4_GoldenMilletPresentViewContainer
