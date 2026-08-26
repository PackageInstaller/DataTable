-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyMembersTipViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyMembersTipViewContainer", package.seeall)

local OdysseyMembersTipViewContainer = class("OdysseyMembersTipViewContainer", BaseViewContainer)

function OdysseyMembersTipViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseyMembersTipView.New())

	return views
end

return OdysseyMembersTipViewContainer
