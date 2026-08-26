-- chunkname: @modules/logic/fight/system/work/FightWorkMagicCircleUpdate.lua

module("modules.logic.fight.system.work.FightWorkMagicCircleUpdate", package.seeall)

local FightWorkMagicCircleUpdate = class("FightWorkMagicCircleUpdate", FightEffectBase)

function FightWorkMagicCircleUpdate:onStart()
	local magicData = FightModel.instance:getMagicCircleInfo()

	if magicData then
		local magicCircleId = self.actEffectData.magicCircle.magicCircleId

		if magicData.magicCircleId == magicCircleId then
			magicData:refreshData(self.actEffectData.magicCircle)
		end

		local config = lua_magic_circle.configDict[magicCircleId]

		if config then
			FightController.instance:dispatchEvent(FightEvent.UpdateMagicCircile, magicCircleId, self.fightStepData.fromId)
		else
			logError("术阵表找不到id:" .. magicCircleId)
		end
	end

	self:_delayDone()
end

function FightWorkMagicCircleUpdate:_delayDone()
	self:onDone(true)
end

function FightWorkMagicCircleUpdate:clearWork()
	return
end

return FightWorkMagicCircleUpdate
