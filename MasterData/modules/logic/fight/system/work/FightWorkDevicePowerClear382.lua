-- chunkname: @modules/logic/fight/system/work/FightWorkDevicePowerClear382.lua

module("modules.logic.fight.system.work.FightWorkDevicePowerClear382", package.seeall)

local FightWorkDevicePowerClear382 = class("FightWorkDevicePowerClear382", FightEffectBase)

function FightWorkDevicePowerClear382:onStart()
	FightController.instance:dispatchEvent(FightEvent.OnDevice_PowerChange)

	return self:onDone(true)
end

return FightWorkDevicePowerClear382
