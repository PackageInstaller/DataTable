-- chunkname: @modules/logic/fight/system/work/FightWorkRougePowerChange.lua

module("modules.logic.fight.system.work.FightWorkRougePowerChange", package.seeall)

local FightWorkRougePowerChange = class("FightWorkRougePowerChange", FightEffectBase)

function FightWorkRougePowerChange:onStart()
	local value = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Magic)

	FightModel.instance:setRougeExData(FightEnum.ExIndexForRouge.Magic, value + self.actEffectData.effectNum)
	FightController.instance:dispatchEvent(FightEvent.RougeMagicChange)
	self:onDone(true)
end

function FightWorkRougePowerChange:clearWork()
	return
end

return FightWorkRougePowerChange
