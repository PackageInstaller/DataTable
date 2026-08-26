-- chunkname: @modules/logic/fight/system/work/FightWorkClearAiJiAoQteTempData.lua

module("modules.logic.fight.system.work.FightWorkClearAiJiAoQteTempData", package.seeall)

local FightWorkClearAiJiAoQteTempData = class("FightWorkClearAiJiAoQteTempData", FightWorkItem)

function FightWorkClearAiJiAoQteTempData:onStart()
	FightDataHelper.tempMgr.aiJiAoFakeHpDic = {}
	FightDataHelper.tempMgr.aiJiAoFakeShieldDic = {}
	FightDataHelper.tempMgr.aiJiAoQteCount = 0
	FightDataHelper.tempMgr.aiJiAoQteEndlessLoop = 0

	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.AiJiAoQteIng)
	self:onDone(true)
end

return FightWorkClearAiJiAoQteTempData
