-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomNpcEasterEggViewContainer.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomNpcEasterEggViewContainer", package.seeall)

local ChatRoomNpcEasterEggViewContainer = class("ChatRoomNpcEasterEggViewContainer", BaseViewContainer)

function ChatRoomNpcEasterEggViewContainer:buildViews()
	local views = {}

	table.insert(views, ChatRoomNpcEasterEggView.New())

	return views
end

function ChatRoomNpcEasterEggViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return ChatRoomNpcEasterEggViewContainer
