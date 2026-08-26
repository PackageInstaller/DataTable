-- chunkname: @modules/logic/tower/view/fight/TowerPermanentResultViewContainer.lua

module("modules.logic.tower.view.fight.TowerPermanentResultViewContainer", package.seeall)

local TowerPermanentResultViewContainer = class("TowerPermanentResultViewContainer", BaseViewContainer)

function TowerPermanentResultViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerPermanentResultView.New())

	return views
end

return TowerPermanentResultViewContainer
