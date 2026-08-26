-- chunkname: @modules/logic/fight/system/work/FightWorkSaveFightRecordUpdate.lua

module("modules.logic.fight.system.work.FightWorkSaveFightRecordUpdate", package.seeall)

local FightWorkSaveFightRecordUpdate = class("FightWorkSaveFightRecordUpdate", FightEffectBase)

function FightWorkSaveFightRecordUpdate:beforePlayEffectData()
	if self.actEffectData.entity then
		local entityId = self.actEffectData.entity.uid
		local entity = entityId and FightHelper.getEntity(entityId)
		local entityMo = entity and entity:getMO()

		if entityMo then
			self.beforeHp = entityMo.currentHp or 0
		end
	end
end

function FightWorkSaveFightRecordUpdate:onStart()
	if self.actEffectData.entity then
		local entityId = self.actEffectData.entity.uid
		local entity = entityId and FightHelper.getEntity(entityId)

		if not entity then
			return
		end

		if entity.nameUI then
			entity.nameUI:resetHp()
		end

		local entityMo = entity and entity:getMO()

		if entityMo then
			if not entityMo.currentHp then
				local curHp = 0

				FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, curHp - self.beforeHp)

				return self:onDone(true)
			end
		end
	end
end

return FightWorkSaveFightRecordUpdate
