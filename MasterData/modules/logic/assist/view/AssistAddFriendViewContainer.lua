-- chunkname: @modules/logic/assist/view/AssistAddFriendViewContainer.lua

module("modules.logic.assist.view.AssistAddFriendViewContainer", package.seeall)

local AssistAddFriendViewContainer = class("AssistAddFriendViewContainer", BaseViewContainer)

function AssistAddFriendViewContainer:buildViews()
	local views = {}

	table.insert(views, AssistAddFriendView.New())

	return views
end

return AssistAddFriendViewContainer
