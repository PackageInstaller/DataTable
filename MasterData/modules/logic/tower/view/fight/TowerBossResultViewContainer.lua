-- chunkname: @modules/logic/tower/view/fight/TowerBossResultViewContainer.lua

module("modules.logic.tower.view.fight.TowerBossResultViewContainer", package.seeall)

local TowerBossResultViewContainer = class("TowerBossResultViewContainer", BaseViewContainer)

function TowerBossResultViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerBossResultView.New())

	return views
end

return TowerBossResultViewContainer
