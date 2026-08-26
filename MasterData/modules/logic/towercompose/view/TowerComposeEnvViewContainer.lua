-- chunkname: @modules/logic/towercompose/view/TowerComposeEnvViewContainer.lua

module("modules.logic.towercompose.view.TowerComposeEnvViewContainer", package.seeall)

local TowerComposeEnvViewContainer = class("TowerComposeEnvViewContainer", BaseViewContainer)

function TowerComposeEnvViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeEnvView.New())

	return views
end

return TowerComposeEnvViewContainer
