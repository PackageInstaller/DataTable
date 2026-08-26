-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookInfoViewContainer.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookInfoViewContainer", package.seeall)

local SurvivalHandbookInfoViewContainer = class("SurvivalHandbookInfoViewContainer", BaseViewContainer)

function SurvivalHandbookInfoViewContainer:buildViews()
	return {
		SurvivalHandbookInfoView.New()
	}
end

function SurvivalHandbookInfoViewContainer:buildTabViews(tabContainerId)
	return
end

function SurvivalHandbookInfoViewContainer:onContainerOpenFinish()
	return
end

return SurvivalHandbookInfoViewContainer
