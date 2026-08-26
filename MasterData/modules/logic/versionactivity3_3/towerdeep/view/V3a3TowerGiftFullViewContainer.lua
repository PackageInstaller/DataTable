-- chunkname: @modules/logic/versionactivity3_3/towerdeep/view/V3a3TowerGiftFullViewContainer.lua

module("modules.logic.versionactivity3_3.towerdeep.view.V3a3TowerGiftFullViewContainer", package.seeall)

local V3a3TowerGiftFullViewContainer = class("V3a3TowerGiftFullViewContainer", BaseViewContainer)

function V3a3TowerGiftFullViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a3TowerGiftFullView.New())

	return views
end

return V3a3TowerGiftFullViewContainer
