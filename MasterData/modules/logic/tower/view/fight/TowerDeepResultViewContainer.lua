-- chunkname: @modules/logic/tower/view/fight/TowerDeepResultViewContainer.lua

module("modules.logic.tower.view.fight.TowerDeepResultViewContainer", package.seeall)

local TowerDeepResultViewContainer = class("TowerDeepResultViewContainer", BaseViewContainer)

function TowerDeepResultViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerDeepResultView.New())

	return views
end

return TowerDeepResultViewContainer
