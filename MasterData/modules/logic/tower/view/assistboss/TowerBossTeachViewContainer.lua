-- chunkname: @modules/logic/tower/view/assistboss/TowerBossTeachViewContainer.lua

module("modules.logic.tower.view.assistboss.TowerBossTeachViewContainer", package.seeall)

local TowerBossTeachViewContainer = class("TowerBossTeachViewContainer", BaseViewContainer)

function TowerBossTeachViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerBossTeachView.New())

	return views
end

return TowerBossTeachViewContainer
