-- chunkname: @modules/logic/fight/system/work/fightparamwork/FightParamChangeWork20.lua

module("modules.logic.fight.system.work.fightparamwork.FightParamChangeWork20", package.seeall)

local FightParamChangeWork20 = class("FightParamChangeWork20", FightParamWorkBase)

function FightParamChangeWork20:onStart()
	FightDataHelper.tempMgr.douQuQuNewDice = true
	FightDataHelper.tempMgr.douQuQuDice = true
	FightDataHelper.tempMgr.douQuQuNewDiceOffset = self.offset

	self:com_registFightEvent(FightEvent.OnDiceEnd, self._onDiceEnd)
	self:com_registTimer(self.finishWork, 10)

	local viewName = ViewName.FightDiceView

	ViewMgr.instance:openView(viewName)
	self:cancelFightWorkSafeTimer()
end

function FightParamChangeWork20:_onDiceEnd()
	self:onDone(true)
end

return FightParamChangeWork20
