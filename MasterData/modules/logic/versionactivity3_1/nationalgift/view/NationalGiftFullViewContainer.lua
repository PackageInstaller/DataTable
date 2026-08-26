-- chunkname: @modules/logic/versionactivity3_1/nationalgift/view/NationalGiftFullViewContainer.lua

module("modules.logic.versionactivity3_1.nationalgift.view.NationalGiftFullViewContainer", package.seeall)

local NationalGiftFullViewContainer = class("NationalGiftFullViewContainer", BaseViewContainer)

function NationalGiftFullViewContainer:buildViews()
	local views = {}

	table.insert(views, NationalGiftFullView.New())

	return views
end

return NationalGiftFullViewContainer
