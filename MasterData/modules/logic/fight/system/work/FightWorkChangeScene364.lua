-- chunkname: @modules/logic/fight/system/work/FightWorkChangeScene364.lua

module("modules.logic.fight.system.work.FightWorkChangeScene364", package.seeall)

local FightWorkChangeScene364 = class("FightWorkChangeScene364", FightEffectBase)

function FightWorkChangeScene364:onStart()
	local levelId = self.actEffectData.effectNum

	FightController.instance:dispatchEvent(FightEvent.SwitchScene_Data, levelId)

	return self:onDone(true)
end

return FightWorkChangeScene364
