-- chunkname: @modules/logic/fight/system/work/FightWorkSummonedAdd.lua

module("modules.logic.fight.system.work.FightWorkSummonedAdd", package.seeall)

local FightWorkSummonedAdd = class("FightWorkSummonedAdd", FightEffectBase)

function FightWorkSummonedAdd:onStart()
	self._targetId = self.actEffectData.targetId

	local entityMO = FightDataHelper.entityMgr:getById(self._targetId)

	if entityMO and self.actEffectData.summoned then
		local summonedInfo = entityMO:getSummonedInfo()
		local data = summonedInfo:getData(self.actEffectData.summoned.uid)
		local config = FightConfig.instance:getSummonedConfig(data.summonedId, data.level)

		if config then
			self:com_registTimer(self._delayDone, config.enterTime / 1000 / FightModel.instance:getSpeed())
			FightController.instance:dispatchEvent(FightEvent.SummonedAdd, self._targetId, data)

			return
		end

		logError("挂件表找不到id:" .. data.summonedId .. "  等级:" .. data.level)
	end

	self:_delayDone()
end

function FightWorkSummonedAdd:_delayDone()
	self:onDone(true)
end

function FightWorkSummonedAdd:clearWork()
	return
end

return FightWorkSummonedAdd
