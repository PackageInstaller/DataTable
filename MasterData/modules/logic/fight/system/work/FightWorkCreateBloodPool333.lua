-- chunkname: @modules/logic/fight/system/work/FightWorkCreateBloodPool333.lua

module("modules.logic.fight.system.work.FightWorkCreateBloodPool333", package.seeall)

local FightWorkCreateBloodPool333 = class("FightWorkCreateBloodPool333", FightEffectBase)

function FightWorkCreateBloodPool333:onStart()
	local configEffect = self.actEffectData.configEffect

	if configEffect == FightEnum.BloodPoolConfigEffect.BloodPool then
		self:handleBloodPool()
	elseif configEffect == FightEnum.BloodPoolConfigEffect.HeatScale then
		self:handleHeatScale()
	end
end

function FightWorkCreateBloodPool333:handleBloodPool()
	local teamType = self.actEffectData.effectNum
	local teamDataMgr = FightDataHelper.teamDataMgr

	teamDataMgr:checkBloodPoolExist(teamType)

	local pool = teamDataMgr[teamType].bloodPool

	pool:changeMaxValue(self.actEffectData.effectNum1)
	FightController.instance:dispatchEvent(FightEvent.BloodPool_OnCreate, teamType)
	self:onDone(true)
end

function FightWorkCreateBloodPool333:handleHeatScale()
	local teamType = self.actEffectData.effectNum
	local teamDataMgr = FightDataHelper.teamDataMgr

	teamDataMgr:checkHeatScaleExist(teamType)

	local heatScale = teamDataMgr[teamType].heatScale

	heatScale:changeMaxValue(self.actEffectData.effectNum1)
	FightController.instance:dispatchEvent(FightEvent.HeatScale_OnCreate, teamType)
	self:onDone(true)
end

return FightWorkCreateBloodPool333
