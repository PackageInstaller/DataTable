-- chunkname: @modules/logic/sp01/odyssey/view/OdysseySuitTipViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseySuitTipViewContainer", package.seeall)

local OdysseySuitTipViewContainer = class("OdysseySuitTipViewContainer", BaseViewContainer)

function OdysseySuitTipViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseySuitTipView.New())

	return views
end

return OdysseySuitTipViewContainer
