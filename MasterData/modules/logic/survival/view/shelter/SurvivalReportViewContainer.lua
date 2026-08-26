-- chunkname: @modules/logic/survival/view/shelter/SurvivalReportViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalReportViewContainer", package.seeall)

local SurvivalReportViewContainer = class("SurvivalReportViewContainer", BaseViewContainer)

function SurvivalReportViewContainer:buildViews()
	return {
		SurvivalReportView.New()
	}
end

return SurvivalReportViewContainer
