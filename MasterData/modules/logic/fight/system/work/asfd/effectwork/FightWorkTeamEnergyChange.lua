-- chunkname: @modules/logic/fight/system/work/asfd/effectwork/FightWorkTeamEnergyChange.lua

module("modules.logic.fight.system.work.asfd.effectwork.FightWorkTeamEnergyChange", package.seeall)

local FightWorkTeamEnergyChange = class("FightWorkTeamEnergyChange", FightEffectBase)

function FightWorkTeamEnergyChange:onConstructor()
	self.SAFETIME = 1
end

function FightWorkTeamEnergyChange:beforePlayEffectData()
	local side = self.actEffectData.effectNum

	self.beforeEnergy = FightDataHelper.ASFDDataMgr:getEnergy(side) or 0
end

FightWorkTeamEnergyChange.WaitTime = 0.2

function FightWorkTeamEnergyChange:onStart()
	local side = self.actEffectData.effectNum
	local curEnergy = FightDataHelper.ASFDDataMgr:getEnergy(side)

	FightController.instance:dispatchEvent(FightEvent.ASFD_TeamEnergyChange, side, self.beforeEnergy, curEnergy)

	local waitTime = FightWorkTeamEnergyChange.WaitTime / FightModel.instance:getSpeed()

	self:com_registTimer(self._delayDone, waitTime)
end

return FightWorkTeamEnergyChange
