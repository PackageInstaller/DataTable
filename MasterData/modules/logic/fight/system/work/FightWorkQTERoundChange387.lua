-- chunkname: @modules/logic/fight/system/work/FightWorkQTERoundChange387.lua

module("modules.logic.fight.system.work.FightWorkQTERoundChange387", package.seeall)

local FightWorkQTERoundChange387 = class("FightWorkQTERoundChange387", FightEffectBase)

function FightWorkQTERoundChange387:onStart()
	local qteInfo = FightDataHelper.qteDataMgr:getQteInfo()

	if not qteInfo then
		return self:onDone(true)
	end

	local curStatus = qteInfo:getStatus()

	self:com_sendFightEvent(FightEvent.QTE_OnStageChange, curStatus)

	if curStatus == FightEnum.QTEStage.Normal then
		return self:exitQte()
	elseif curStatus == FightEnum.QTEStage.QTE_FIRST then
		return self:enterQte()
	elseif curStatus == FightEnum.QTEStage.QTE_SECOND then
		return self:enterQteSecond()
	end

	return self:onDone(true)
end

function FightWorkQTERoundChange387:exitQte()
	self:cancelFightWorkSafeTimer()
	self:com_registTimer(self._fightWorkSafeTimer, 10)

	local work = self:com_registWork(FightWorkExitQTE)

	work:registFinishCallback(self._delayDone, self)
	work:start()
end

function FightWorkQTERoundChange387:enterQte()
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.QTE)
	ViewMgr.instance:openView(ViewName.FightQteView)

	return self:onDone(true)
end

function FightWorkQTERoundChange387:enterQteSecond()
	self:com_sendFightEvent(FightEvent.QTE_EnterSecond)

	return self:onDone(true)
end

return FightWorkQTERoundChange387
