-- chunkname: @modules/logic/fight/system/work/FightWorkBloodPoolValueChange335.lua

module("modules.logic.fight.system.work.FightWorkBloodPoolValueChange335", package.seeall)

local FightWorkBloodPoolValueChange335 = class("FightWorkBloodPoolValueChange335", FightEffectBase)

function FightWorkBloodPoolValueChange335:onStart()
	local configEffect = self.actEffectData.configEffect

	if configEffect == FightEnum.BloodPoolConfigEffect.BloodPool then
		self:handleBloodPool()
	elseif configEffect == FightEnum.BloodPoolConfigEffect.HeatScale then
		self:handleHeatScale()
	end
end

function FightWorkBloodPoolValueChange335:handleBloodPool()
	local teamType = self.actEffectData.effectNum
	local teamDataMgr = FightDataHelper.teamDataMgr

	teamDataMgr:checkBloodPoolExist(teamType)

	local pool = teamDataMgr[teamType].bloodPool

	pool:changeValue(self.actEffectData.effectNum1)
	FightController.instance:dispatchEvent(FightEvent.BloodPool_ValueChange, teamType)
	self:onDone(true)
end

function FightWorkBloodPoolValueChange335:handleHeatScale()
	local teamType = self.actEffectData.effectNum
	local teamDataMgr = FightDataHelper.teamDataMgr

	teamDataMgr:checkHeatScaleExist(teamType)

	local heatScale = teamDataMgr[teamType].heatScale

	heatScale:changeValue(self.actEffectData.effectNum1)
	FightController.instance:dispatchEvent(FightEvent.HeatScale_ValueChange, teamType)
	self:onDone(true)
end

return FightWorkBloodPoolValueChange335
