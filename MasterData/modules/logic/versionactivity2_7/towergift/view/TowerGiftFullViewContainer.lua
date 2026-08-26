-- chunkname: @modules/logic/versionactivity2_7/towergift/view/TowerGiftFullViewContainer.lua

module("modules.logic.versionactivity2_7.towergift.view.TowerGiftFullViewContainer", package.seeall)

local TowerGiftFullViewContainer = class("TowerGiftFullViewContainer", BaseViewContainer)

function TowerGiftFullViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerGiftFullView.New())

	return views
end

return TowerGiftFullViewContainer
