-- chunkname: @modules/logic/sp01/assassinChase/view/AssassinChaseChatViewContainer.lua

module("modules.logic.sp01.assassinChase.view.AssassinChaseChatViewContainer", package.seeall)

local AssassinChaseChatViewContainer = class("AssassinChaseChatViewContainer", BaseViewContainer)

function AssassinChaseChatViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinChaseChatView.New())

	return views
end

return AssassinChaseChatViewContainer
