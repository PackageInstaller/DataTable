-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/model/fingergame/ChatRoomFingerGameCardMO.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.model.fingergame.ChatRoomFingerGameCardMO", package.seeall)

local ChatRoomFingerGameCardMO = pureTable("ChatRoomFingerGameCardMO")

function ChatRoomFingerGameCardMO:setData(cardType, isFlipped)
	self.cardType = cardType
	self.isFlipped = isFlipped
end

function ChatRoomFingerGameCardMO:setIsFlipped(value)
	self.isFlipped = value
end

return ChatRoomFingerGameCardMO
