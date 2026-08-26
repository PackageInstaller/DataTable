-- chunkname: @modules/logic/main/view/XRAnSkinInteractionViewContainer.lua

module("modules.logic.main.view.XRAnSkinInteractionViewContainer", package.seeall)

local XRAnSkinInteractionViewContainer = class("XRAnSkinInteractionViewContainer", BaseViewContainer)

function XRAnSkinInteractionViewContainer:buildViews()
	local views = {}

	table.insert(views, XRAnSkinInteractionView.New())

	return views
end

return XRAnSkinInteractionViewContainer
