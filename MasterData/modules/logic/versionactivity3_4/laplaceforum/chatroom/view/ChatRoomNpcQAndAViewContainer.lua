-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomNpcQAndAViewContainer.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomNpcQAndAViewContainer", package.seeall)

local ChatRoomNpcQAndAViewContainer = class("ChatRoomNpcQAndAViewContainer", BaseViewContainer)

function ChatRoomNpcQAndAViewContainer:buildViews()
	local views = {}

	table.insert(views, ChatRoomNpcQAndAView.New())

	return views
end

function ChatRoomNpcQAndAViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return ChatRoomNpcQAndAViewContainer
