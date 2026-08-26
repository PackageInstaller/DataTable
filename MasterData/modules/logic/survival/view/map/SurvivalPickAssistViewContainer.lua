-- chunkname: @modules/logic/survival/view/map/SurvivalPickAssistViewContainer.lua

module("modules.logic.survival.view.map.SurvivalPickAssistViewContainer", package.seeall)

local SurvivalPickAssistViewContainer = class("SurvivalPickAssistViewContainer", PickAssistViewContainer)

function SurvivalPickAssistViewContainer:buildViews()
	self.viewOpenAnimTime = 0.4
	self.scrollView = self:instantiateListScrollView()

	return {
		SurvivalPickAssistView.New(),
		self.scrollView,
		TabViewGroup.New(1, "#go_lefttopbtns")
	}
end

return SurvivalPickAssistViewContainer
