-- chunkname: @modules/logic/towercompose/view/TowerModeChangeViewContainer.lua

module("modules.logic.towercompose.view.TowerModeChangeViewContainer", package.seeall)

local TowerModeChangeViewContainer = class("TowerModeChangeViewContainer", BaseViewContainer)

function TowerModeChangeViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerModeChangeView.New())

	return views
end

return TowerModeChangeViewContainer
