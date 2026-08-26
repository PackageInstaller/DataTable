-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/controller/Work/ChatRoomFingerGameEventWork.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.controller.Work.ChatRoomFingerGameEventWork", package.seeall)

local ChatRoomFingerGameEventWork = class("ChatRoomFingerGameEventWork", BaseWork)

function ChatRoomFingerGameEventWork:ctor(event, eventParam)
	self.event = event
	self.eventParam = eventParam
end

function ChatRoomFingerGameEventWork:onStart()
	ChatRoomController.instance:dispatchEvent(self.event, self.eventParam)
	self:onDone(true)
end

function ChatRoomFingerGameEventWork:onDestroy()
	return
end

return ChatRoomFingerGameEventWork
