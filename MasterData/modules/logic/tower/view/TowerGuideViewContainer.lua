-- chunkname: @modules/logic/tower/view/TowerGuideViewContainer.lua

module("modules.logic.tower.view.TowerGuideViewContainer", package.seeall)

local TowerGuideViewContainer = class("TowerGuideViewContainer", BaseViewContainer)

function TowerGuideViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerGuideView.New())

	return views
end

return TowerGuideViewContainer
