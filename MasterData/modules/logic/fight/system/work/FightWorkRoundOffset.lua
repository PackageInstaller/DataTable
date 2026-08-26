-- chunkname: @modules/logic/fight/system/work/FightWorkRoundOffset.lua

module("modules.logic.fight.system.work.FightWorkRoundOffset", package.seeall)

local FightWorkRoundOffset = class("FightWorkRoundOffset", FightEffectBase)

function FightWorkRoundOffset:onStart()
	local srcMaxRound = FightModel.instance:getMaxRound()
	local roundOffset = self.actEffectData.effectNum

	FightModel.instance.maxRound = srcMaxRound + roundOffset

	FightModel.instance:setRoundOffset(roundOffset)
	FightController.instance:dispatchEvent(FightEvent.RefreshUIRound)

	return self:onDone(true)
end

return FightWorkRoundOffset
