-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomLuckyRainViewContainer.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomLuckyRainViewContainer", package.seeall)

local ChatRoomLuckyRainViewContainer = class("ChatRoomLuckyRainViewContainer", BaseViewContainer)

function ChatRoomLuckyRainViewContainer:buildViews()
	local views = {}

	table.insert(views, ChatRoomLuckyRainView.New())

	return views
end

return ChatRoomLuckyRainViewContainer
