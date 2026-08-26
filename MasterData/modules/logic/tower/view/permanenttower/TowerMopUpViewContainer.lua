-- chunkname: @modules/logic/tower/view/permanenttower/TowerMopUpViewContainer.lua

module("modules.logic.tower.view.permanenttower.TowerMopUpViewContainer", package.seeall)

local TowerMopUpViewContainer = class("TowerMopUpViewContainer", BaseViewContainer)

function TowerMopUpViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerMopUpView.New())

	return views
end

return TowerMopUpViewContainer
