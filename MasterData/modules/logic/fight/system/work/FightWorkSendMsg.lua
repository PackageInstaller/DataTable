-- chunkname: @modules/logic/fight/system/work/FightWorkSendMsg.lua

module("modules.logic.fight.system.work.FightWorkSendMsg", package.seeall)

local FightWorkSendMsg = class("FightWorkSendMsg", FightWorkItem)

function FightWorkSendMsg:onLogicEnter(msgId, ...)
	self.msgId = msgId
	self.param = {
		...
	}
	self.paramCount = select("#", ...)
end

function FightWorkSendMsg:onStart()
	FightMsgMgr.sendMsg(self.msgId, unpack(self.param, 1, self.paramCount))
	self:onDone(true)
end

return FightWorkSendMsg
