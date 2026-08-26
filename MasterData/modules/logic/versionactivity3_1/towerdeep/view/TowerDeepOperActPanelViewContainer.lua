-- chunkname: @modules/logic/versionactivity3_1/towerdeep/view/TowerDeepOperActPanelViewContainer.lua

module("modules.logic.versionactivity3_1.towerdeep.view.TowerDeepOperActPanelViewContainer", package.seeall)

local TowerDeepOperActPanelViewContainer = class("TowerDeepOperActPanelViewContainer", BaseViewContainer)

function TowerDeepOperActPanelViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerDeepOperActPanelView.New())

	return views
end

return TowerDeepOperActPanelViewContainer
