-- chunkname: @modules/logic/fight/system/work/FightWorkMagicCircleAdd.lua

module("modules.logic.fight.system.work.FightWorkMagicCircleAdd", package.seeall)

local FightWorkMagicCircleAdd = class("FightWorkMagicCircleAdd", FightEffectBase)

function FightWorkMagicCircleAdd:onStart()
	local magicData = FightModel.instance:getMagicCircleInfo()

	if magicData then
		local magicCircleId = self.actEffectData.magicCircle.magicCircleId

		magicData:refreshData(self.actEffectData.magicCircle)

		local config = lua_magic_circle.configDict[magicCircleId]

		if config then
			local delayTime = math.max(config.enterTime / 1000, 0.7)

			self:com_registTimer(self._delayDone, delayTime / FightModel.instance:getSpeed())
			FightController.instance:dispatchEvent(FightEvent.AddMagicCircile, magicCircleId, self.fightStepData.fromId)

			return
		end

		logError("术阵表找不到id:" .. magicCircleId)
	end

	self:_delayDone()
end

function FightWorkMagicCircleAdd:_delayDone()
	self:onDone(true)
end

function FightWorkMagicCircleAdd:clearWork()
	return
end

return FightWorkMagicCircleAdd
