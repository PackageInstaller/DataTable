-- chunkname: @modules/logic/fight/system/work/FightWorkAddMaxRound356.lua

module("modules.logic.fight.system.work.FightWorkAddMaxRound356", package.seeall)

local FightWorkAddMaxRound356 = class("FightWorkAddMaxRound356", FightEffectBase)

function FightWorkAddMaxRound356:onStart()
	AudioMgr.instance:trigger(20320143)
	FightController.instance:dispatchEvent(FightEvent.RefreshMaxRoundUI, self.actEffectData.effectNum)

	return self:onDone(true)
end

return FightWorkAddMaxRound356
