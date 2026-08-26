-- chunkname: @modules/logic/towercompose/view/TowerComposeModDescTipViewContainer.lua

module("modules.logic.towercompose.view.TowerComposeModDescTipViewContainer", package.seeall)

local TowerComposeModDescTipViewContainer = class("TowerComposeModDescTipViewContainer", BaseViewContainer)

function TowerComposeModDescTipViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeModDescTipView.New())

	return views
end

return TowerComposeModDescTipViewContainer
