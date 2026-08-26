-- chunkname: @modules/logic/versionactivity3_3/towerdeep/view/V3a3TowerGiftPanelViewContainer.lua

module("modules.logic.versionactivity3_3.towerdeep.view.V3a3TowerGiftPanelViewContainer", package.seeall)

local V3a3TowerGiftPanelViewContainer = class("V3a3TowerGiftPanelViewContainer", BaseViewContainer)

function V3a3TowerGiftPanelViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a3TowerGiftPanelView.New())

	return views
end

return V3a3TowerGiftPanelViewContainer
