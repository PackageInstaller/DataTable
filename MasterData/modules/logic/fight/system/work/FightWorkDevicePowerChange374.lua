-- chunkname: @modules/logic/fight/system/work/FightWorkDevicePowerChange374.lua

module("modules.logic.fight.system.work.FightWorkDevicePowerChange374", package.seeall)

local FightWorkDevicePowerChange374 = class("FightWorkDevicePowerChange374", FightEffectBase)

function FightWorkDevicePowerChange374:onStart()
	local changeFrom = self.actEffectData.effectNum
	local changeStr = self.actEffectData.reserveStr
	local changeArray = FightStrUtil.instance:getSplitString2Cache(changeStr, true)

	if not changeArray then
		return self:onDone(true)
	end

	local reducePower = false
	local addPower = false

	for _, array in ipairs(changeArray) do
		local changeValue = array[2]

		if changeValue > 0 then
			addPower = true

			break
		end

		if array[2] < 0 then
			reducePower = true
		end
	end

	if addPower or reducePower then
		FightController.instance:dispatchEvent(FightEvent.OnDevice_PowerChange, self.actEffectData.reserveStr, changeFrom)
	end

	if addPower then
		self:com_registTimer(self._delayDone, 0.5)
	else
		return self:onDone(true)
	end
end

return FightWorkDevicePowerChange374
