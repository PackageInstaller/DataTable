-- chunkname: @modules/logic/versionactivity1_6/goldenmilletpresent/view/GoldenMilletPresentViewContainer.lua

module("modules.logic.versionactivity1_6.goldenmilletpresent.view.GoldenMilletPresentViewContainer", package.seeall)

local GoldenMilletPresentViewContainer = class("GoldenMilletPresentViewContainer", BaseViewContainer)

GoldenMilletPresentViewContainer.ExclusiveView = {
	DisplayView = 2,
	ReceiveView = 1
}

function GoldenMilletPresentViewContainer:buildViews()
	self.goldenMilletPresentView = GoldenMilletPresentView.New()

	return {
		self.goldenMilletPresentView
	}
end

function GoldenMilletPresentViewContainer:openGoldMilletPresentDisplayView()
	self.goldenMilletPresentView:switchExclusiveView(true)
end

return GoldenMilletPresentViewContainer
