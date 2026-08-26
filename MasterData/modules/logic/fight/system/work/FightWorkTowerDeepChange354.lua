-- chunkname: @modules/logic/fight/system/work/FightWorkTowerDeepChange354.lua

module("modules.logic.fight.system.work.FightWorkTowerDeepChange354", package.seeall)

local FightWorkTowerDeepChange354 = class("FightWorkTowerDeepChange354", FightEffectBase)

function FightWorkTowerDeepChange354:beforePlayEffectData()
	self.indicatorId = FightEnum.IndicatorId.TowerDeep

	local data = FightDataHelper.fieldMgr.indicatorDict[self.indicatorId]

	if data then
		self._beforeScore = data.num or 0
	end
end

function FightWorkTowerDeepChange354:onStart()
	local data = FightDataHelper.fieldMgr.indicatorDict[self.indicatorId]

	if data then
		self._curScore = data.num or 0
	end

	self:com_sendFightEvent(FightEvent.OnTowerDeepChange, self._beforeScore, self._curScore)
	self:onDone(true)
end

return FightWorkTowerDeepChange354
