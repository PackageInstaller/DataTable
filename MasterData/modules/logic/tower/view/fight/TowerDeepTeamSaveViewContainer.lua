-- chunkname: @modules/logic/tower/view/fight/TowerDeepTeamSaveViewContainer.lua

module("modules.logic.tower.view.fight.TowerDeepTeamSaveViewContainer", package.seeall)

local TowerDeepTeamSaveViewContainer = class("TowerDeepTeamSaveViewContainer", BaseViewContainer)

function TowerDeepTeamSaveViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerDeepTeamSaveView.New())

	return views
end

return TowerDeepTeamSaveViewContainer
