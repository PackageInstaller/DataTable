-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/model/MyChatMsgObj.lua

module("logic.extensions.chat.model.MyChatMsgObj", package.seeall)

local MyChatMsgObj = class("MyChatMsgObj", ChatMsgObj)

function MyChatMsgObj:ctor()
	return
end

function MyChatMsgObj:Init(data)
	MyChatMsgObj.super.Init(self, data)

	self._receiveId = tonumber(data.receiveId)

	return self
end

function MyChatMsgObj:GetReceiveId()
	return self._receiveId
end

function MyChatMsgObj:ToTable()
	local t = MyChatMsgObj.super.ToTable(self)

	t.type = 1
	t.receiveId = self._receiveId

	return t
end

return MyChatMsgObj
