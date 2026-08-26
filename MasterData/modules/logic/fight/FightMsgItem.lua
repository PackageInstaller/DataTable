-- chunkname: @modules/logic/fight/FightMsgItem.lua

module("modules.logic.fight.FightMsgItem", package.seeall)

local FightMsgItem = class("FightMsgItem")

function FightMsgItem:ctor(msgId, callback, handle)
	self.msgId = msgId
	self.callback = callback
	self.handle = handle
end

return FightMsgItem
