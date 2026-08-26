-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyItemTipViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyItemTipViewContainer", package.seeall)

local OdysseyItemTipViewContainer = class("OdysseyItemTipViewContainer", BaseViewContainer)

function OdysseyItemTipViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseyItemTipView.New())

	return views
end

return OdysseyItemTipViewContainer
