-- chunkname: @modules/logic/versionactivity3_4/goldenmilletpresent/view/V3a4_GoldenMilletPresentFullViewContainer.lua

module("modules.logic.versionactivity3_4.goldenmilletpresent.view.V3a4_GoldenMilletPresentFullViewContainer", package.seeall)

local V3a4_GoldenMilletPresentFullViewContainer = class("V3a4_GoldenMilletPresentFullViewContainer", BaseViewContainer)

V3a4_GoldenMilletPresentFullViewContainer.ExclusiveView = {
	DisplayView = 2,
	ReceiveView = 1
}

function V3a4_GoldenMilletPresentFullViewContainer:buildViews()
	self.goldenMilletPresentView = V3a4_GoldenMilletPresentFullView.New()

	return {
		self.goldenMilletPresentView
	}
end

function V3a4_GoldenMilletPresentFullViewContainer:openGoldMilletPresentDisplayView()
	self.goldenMilletPresentView:switchExclusiveView(true)
end

return V3a4_GoldenMilletPresentFullViewContainer
