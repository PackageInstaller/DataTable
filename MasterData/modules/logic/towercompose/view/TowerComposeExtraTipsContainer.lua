-- chunkname: @modules/logic/towercompose/view/TowerComposeExtraTipsContainer.lua

module("modules.logic.towercompose.view.TowerComposeExtraTipsContainer", package.seeall)

local TowerComposeExtraTipsContainer = class("TowerComposeExtraTipsContainer", BaseViewContainer)

function TowerComposeExtraTipsContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeExtraTips.New())

	return views
end

return TowerComposeExtraTipsContainer
