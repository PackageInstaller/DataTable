-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomNpcPlayerInfoViewContainer.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomNpcPlayerInfoViewContainer", package.seeall)

local ChatRoomNpcPlayerInfoViewContainer = class("ChatRoomNpcPlayerInfoViewContainer", BaseViewContainer)

function ChatRoomNpcPlayerInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, ChatRoomNpcPlayerInfoView.New())

	return views
end

function ChatRoomNpcPlayerInfoViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return ChatRoomNpcPlayerInfoViewContainer
