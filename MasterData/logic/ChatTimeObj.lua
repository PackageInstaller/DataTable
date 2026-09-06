-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/model/ChatTimeObj.lua

module("logic.extensions.chat.model.ChatTimeObj", package.seeall)

local ChatTimeObj = class("ChatTimeObj")

function ChatTimeObj:ctor(time)
	self._time = time
end

function ChatTimeObj:GetValue()
	return self._time
end

function ChatTimeObj:getMsgType()
	return GameEnum.ChatType.TimeStamp
end

function ChatTimeObj:getContent()
	return self._time
end

function ChatTimeObj:getChatItemType()
	return GameEnum.ChatItemType.ItemTime
end

return ChatTimeObj
