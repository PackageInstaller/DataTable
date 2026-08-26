-- chunkname: @modules/logic/versionactivity3_7/skingift/view/V3a7_SkinGiftFullViewContainer.lua

module("modules.logic.versionactivity3_7.skingift.view.V3a7_SkinGiftFullViewContainer", package.seeall)

local V3a7_SkinGiftFullViewContainer = class("V3a7_SkinGiftFullViewContainer", BaseViewContainer)

function V3a7_SkinGiftFullViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a7_SkinGiftFullView.New())

	return views
end

return V3a7_SkinGiftFullViewContainer
