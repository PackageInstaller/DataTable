-- chunkname: @modules/logic/versionactivity3_4/destinysummongift/view/V3a4DestinyGiftFullViewContainer.lua

module("modules.logic.versionactivity3_4.destinysummongift.view.V3a4DestinyGiftFullViewContainer", package.seeall)

local V3a4DestinyGiftFullViewContainer = class("V3a4DestinyGiftFullViewContainer", BaseViewContainer)

function V3a4DestinyGiftFullViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a4DestinyGiftFullView.New())

	return views
end

return V3a4DestinyGiftFullViewContainer
