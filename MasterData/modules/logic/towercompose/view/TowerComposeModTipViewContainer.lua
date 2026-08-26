-- chunkname: @modules/logic/towercompose/view/TowerComposeModTipViewContainer.lua

module("modules.logic.towercompose.view.TowerComposeModTipViewContainer", package.seeall)

local TowerComposeModTipViewContainer = class("TowerComposeModTipViewContainer", BaseViewContainer)

function TowerComposeModTipViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeModTipView.New())

	return views
end

return TowerComposeModTipViewContainer
