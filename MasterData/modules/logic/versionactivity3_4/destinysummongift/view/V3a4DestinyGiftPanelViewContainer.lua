-- chunkname: @modules/logic/versionactivity3_4/destinysummongift/view/V3a4DestinyGiftPanelViewContainer.lua

module("modules.logic.versionactivity3_4.destinysummongift.view.V3a4DestinyGiftPanelViewContainer", package.seeall)

local V3a4DestinyGiftPanelViewContainer = class("V3a4DestinyGiftPanelViewContainer", BaseViewContainer)

function V3a4DestinyGiftPanelViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a4DestinyGiftPanelView.New())

	return views
end

return V3a4DestinyGiftPanelViewContainer
