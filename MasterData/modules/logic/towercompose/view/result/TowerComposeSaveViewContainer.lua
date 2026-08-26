-- chunkname: @modules/logic/towercompose/view/result/TowerComposeSaveViewContainer.lua

module("modules.logic.towercompose.view.result.TowerComposeSaveViewContainer", package.seeall)

local TowerComposeSaveViewContainer = class("TowerComposeSaveViewContainer", BaseViewContainer)

function TowerComposeSaveViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeSaveView.New())

	return views
end

return TowerComposeSaveViewContainer
