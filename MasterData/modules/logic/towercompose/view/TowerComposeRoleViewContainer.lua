-- chunkname: @modules/logic/towercompose/view/TowerComposeRoleViewContainer.lua

module("modules.logic.towercompose.view.TowerComposeRoleViewContainer", package.seeall)

local TowerComposeRoleViewContainer = class("TowerComposeRoleViewContainer", BaseViewContainer)

function TowerComposeRoleViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeRoleView.New())

	return views
end

return TowerComposeRoleViewContainer
