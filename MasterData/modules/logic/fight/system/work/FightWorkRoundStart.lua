-- chunkname: @modules/logic/fight/system/work/FightWorkRoundStart.lua

module("modules.logic.fight.system.work.FightWorkRoundStart", package.seeall)

local FightWorkRoundStart = class("FightWorkRoundStart", BaseWork)

function FightWorkRoundStart:onStart(context)
	FightController.instance:dispatchEvent(FightEvent.FightRoundStart)

	FightDataHelper.operationDataMgr.extraMoveAct = 0
	FightLocalDataMgr.instance.extraMoveAct = 0

	self:onDone(true)
end

function FightWorkRoundStart:clearWork()
	return
end

return FightWorkRoundStart
