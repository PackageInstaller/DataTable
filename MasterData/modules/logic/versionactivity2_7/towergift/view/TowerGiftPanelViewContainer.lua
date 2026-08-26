-- chunkname: @modules/logic/versionactivity2_7/towergift/view/TowerGiftPanelViewContainer.lua

module("modules.logic.versionactivity2_7.towergift.view.TowerGiftPanelViewContainer", package.seeall)

local TowerGiftPanelViewContainer = class("TowerGiftPanelViewContainer", BaseViewContainer)

function TowerGiftPanelViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerGiftPanelView.New())

	return views
end

return TowerGiftPanelViewContainer
