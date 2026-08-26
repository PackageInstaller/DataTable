-- chunkname: @modules/logic/fight/fightcomponent/FightMsgComponent.lua

module("modules.logic.fight.fightcomponent.FightMsgComponent", package.seeall)

local FightMsgComponent = class("FightMsgComponent", FightBaseClass)

function FightMsgComponent:onConstructor()
	self.msgList = {}
	self.count = 0
end

function FightMsgComponent:registMsg(msgId, callback, handle)
	local item = FightMsgMgr.registMsg(msgId, callback, handle)

	self.count = self.count + 1
	self.msgList[self.count] = item

	return item
end

function FightMsgComponent:removeMsg(msgItem)
	FightMsgMgr.removeMsg(msgItem)
end

function FightMsgComponent:sendMsg(msgId, ...)
	return FightMsgMgr.sendMsg(msgId, ...)
end

function FightMsgComponent:replyMsg(msgId, reply)
	FightMsgMgr.replyMsg(msgId, reply)
end

function FightMsgComponent:onDestructor()
	local list = self.msgList

	for i = self.count, 1, -1 do
		FightMsgMgr.removeMsg(list[i])
	end
end

return FightMsgComponent
