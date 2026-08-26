-- chunkname: @modules/logic/versionactivity3_1/survivaloperact/view/SurvivalOperActPanelViewContainer.lua

module("modules.logic.versionactivity3_1.survivaloperact.view.SurvivalOperActPanelViewContainer", package.seeall)

local SurvivalOperActPanelViewContainer = class("SurvivalOperActPanelViewContainer", BaseViewContainer)

function SurvivalOperActPanelViewContainer:buildViews()
	local views = {}

	table.insert(views, SurvivalOperActPanelView.New())

	return views
end

return SurvivalOperActPanelViewContainer
