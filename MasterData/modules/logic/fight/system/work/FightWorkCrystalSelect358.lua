-- chunkname: @modules/logic/fight/system/work/FightWorkCrystalSelect358.lua

module("modules.logic.fight.system.work.FightWorkCrystalSelect358", package.seeall)

local FightWorkCrystalSelect358 = class("FightWorkCrystalSelect358", FightEffectBase)

function FightWorkCrystalSelect358:onStart()
	local teamType = self.actEffectData.teamType
	local crystal = self.actEffectData.effectNum
	local data = FightDataHelper.getHeatScale(teamType)

	data:setCrystal(crystal)
	FightController.instance:dispatchEvent(FightEvent.Crystal_ValueChange, teamType)

	local enumId = PlayerEnum.SimpleProperty.BLELastSelectedCrystal

	PlayerModel.instance:forceSetSimpleProperty(enumId, tostring(crystal))
	PlayerRpc.instance:sendSetSimplePropertyRequest(enumId, tostring(crystal))

	return self:onDone(true)
end

return FightWorkCrystalSelect358
