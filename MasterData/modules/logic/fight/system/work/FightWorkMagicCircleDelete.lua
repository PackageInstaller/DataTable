-- chunkname: @modules/logic/fight/system/work/FightWorkMagicCircleDelete.lua

module("modules.logic.fight.system.work.FightWorkMagicCircleDelete", package.seeall)

local FightWorkMagicCircleDelete = class("FightWorkMagicCircleDelete", FightEffectBase)

function FightWorkMagicCircleDelete:onStart()
	local magicData = FightModel.instance:getMagicCircleInfo()

	if magicData then
		local magicCircleId = tonumber(self.actEffectData.reserveId)

		if magicData:deleteData(magicCircleId) then
			local config = lua_magic_circle.configDict[magicCircleId]

			if config then
				local delayTime = math.max(config.closeTime / 1000, 0.3)

				self:com_registTimer(self._delayDone, delayTime / FightModel.instance:getSpeed())
				FightController.instance:dispatchEvent(FightEvent.DeleteMagicCircile, magicCircleId, self.fightStepData.fromId)

				return
			end

			logError("术阵表找不到id:" .. magicCircleId)
		end
	end

	self:_delayDone()
end

function FightWorkMagicCircleDelete:_delayDone()
	self:onDone(true)
end

function FightWorkMagicCircleDelete:clearWork()
	return
end

return FightWorkMagicCircleDelete
