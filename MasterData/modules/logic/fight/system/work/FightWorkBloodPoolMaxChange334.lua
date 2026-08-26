-- chunkname: @modules/logic/fight/system/work/FightWorkBloodPoolMaxChange334.lua

module("modules.logic.fight.system.work.FightWorkBloodPoolMaxChange334", package.seeall)

local FightWorkBloodPoolMaxChange334 = class("FightWorkBloodPoolMaxChange334", FightEffectBase)

function FightWorkBloodPoolMaxChange334:onStart()
	local configEffect = self.actEffectData.configEffect

	if configEffect == FightEnum.BloodPoolConfigEffect.BloodPool then
		self:handleBloodPool()
	elseif configEffect == FightEnum.BloodPoolConfigEffect.HeatScale then
		self:handleHeatScale()
	end
end

function FightWorkBloodPoolMaxChange334:handleBloodPool()
	local teamType = self.actEffectData.effectNum
	local teamDataMgr = FightDataHelper.teamDataMgr

	teamDataMgr:checkBloodPoolExist(teamType)

	local pool = teamDataMgr[teamType].bloodPool

	pool:changeMaxValue(self.actEffectData.effectNum1)
	FightController.instance:dispatchEvent(FightEvent.BloodPool_MaxValueChange, teamType)
	self:onDone(true)
end

function FightWorkBloodPoolMaxChange334:handleHeatScale()
	local teamType = self.actEffectData.effectNum
	local teamDataMgr = FightDataHelper.teamDataMgr

	teamDataMgr:checkHeatScaleExist(teamType)

	local heatScale = teamDataMgr[teamType].heatScale

	heatScale:changeMaxValue(self.actEffectData.effectNum1)
	FightController.instance:dispatchEvent(FightEvent.HeatScale_MaxValueChange, teamType)
	self:onDone(true)
end

return FightWorkBloodPoolMaxChange334
