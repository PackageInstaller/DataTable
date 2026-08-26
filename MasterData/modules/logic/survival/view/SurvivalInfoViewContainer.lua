-- chunkname: @modules/logic/survival/view/SurvivalInfoViewContainer.lua

module("modules.logic.survival.view.SurvivalInfoViewContainer", package.seeall)

local SurvivalInfoViewContainer = class("SurvivalInfoViewContainer", BaseViewContainer)

function SurvivalInfoViewContainer:buildViews()
	return {
		SurvivalInfoView.New()
	}
end

function SurvivalInfoViewContainer:buildTabViews(tabContainerId)
	return
end

return SurvivalInfoViewContainer
