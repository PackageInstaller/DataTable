-- chunkname: @modules/logic/fight/system/work/FightWorkRougeCoinChange.lua

module("modules.logic.fight.system.work.FightWorkRougeCoinChange", package.seeall)

local FightWorkRougeCoinChange = class("FightWorkRougeCoinChange", FightEffectBase)

function FightWorkRougeCoinChange:onStart()
	local value = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Coin)

	FightModel.instance:setRougeExData(FightEnum.ExIndexForRouge.Coin, value + self.actEffectData.effectNum)
	FightController.instance:dispatchEvent(FightEvent.RougeCoinChange, self.actEffectData.effectNum)
	self:onDone(true)
end

function FightWorkRougeCoinChange:clearWork()
	return
end

return FightWorkRougeCoinChange
