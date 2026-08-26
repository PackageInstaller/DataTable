-- chunkname: @modules/logic/fight/system/work/FightWorkWaitMsg.lua

module("modules.logic.fight.system.work.FightWorkWaitMsg", package.seeall)

local FightWorkWaitMsg = class("FightWorkWaitMsg", FightWorkItem)

function FightWorkWaitMsg:onConstructor(msgId)
	self.msgId = msgId
end

function FightWorkWaitMsg:onStart()
	self:com_registMsg(self.msgId, self.onMsg)
	self:cancelFightWorkSafeTimer()
end

function FightWorkWaitMsg:onMsg()
	self:onDone(true)
end

return FightWorkWaitMsg
