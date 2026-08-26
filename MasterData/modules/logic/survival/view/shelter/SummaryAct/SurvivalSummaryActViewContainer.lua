-- chunkname: @modules/logic/survival/view/shelter/SummaryAct/SurvivalSummaryActViewContainer.lua

module("modules.logic.survival.view.shelter.SummaryAct.SurvivalSummaryActViewContainer", package.seeall)

local SurvivalSummaryActViewContainer = class("SurvivalSummaryActViewContainer", BaseViewContainer)

function SurvivalSummaryActViewContainer:buildViews()
	return {
		SurvivalSummaryActView.New()
	}
end

function SurvivalSummaryActViewContainer:buildTabViews(tabContainerId)
	return
end

function SurvivalSummaryActViewContainer:onContainerOpenFinish()
	return
end

return SurvivalSummaryActViewContainer
