-- chunkname: @modules/logic/fight/system/work/FightWorkAct174First.lua

module("modules.logic.fight.system.work.FightWorkAct174First", package.seeall)

local FightWorkAct174First = class("FightWorkAct174First", FightEffectBase)

function FightWorkAct174First:onStart()
	self:com_registTimer(self._delayAfterPerformance, FightEnum.PerformanceTime.DouQuQuXianHouShou)
	self:com_sendMsg(FightMsgId.ShowDouQuQuXianHouShou, self.actEffectData)
end

return FightWorkAct174First
