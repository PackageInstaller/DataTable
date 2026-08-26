-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffStoredExPoint.lua

module("modules.logic.fight.entity.comp.buff.FightBuffStoredExPoint", package.seeall)

local FightBuffStoredExPoint = class("FightBuffStoredExPoint")

function FightBuffStoredExPoint:ctor()
	self.type = nil
end

function FightBuffStoredExPoint:onBuffStart(entity, buffMO)
	self.entity = entity

	local entityMo = entity:getMO()

	if entityMo then
		local oldValue = entityMo:getStoredExPoint()

		entityMo:updateStoredExPoint()
		FightController.instance:dispatchEvent(FightEvent.OnStoreExPointChange, entityMo.id, oldValue)
	end
end

function FightBuffStoredExPoint:onBuffEnd()
	if not self.entity then
		return
	end

	local entityMo = self.entity:getMO()

	if entityMo then
		local oldValue = entityMo:getStoredExPoint()

		entityMo:updateStoredExPoint()
		FightController.instance:dispatchEvent(FightEvent.OnStoreExPointChange, entityMo.id, oldValue)

		local localEntityMo = FightLocalDataMgr.instance.entityMgr:getById(self.entity.id)

		if localEntityMo then
			localEntityMo:updateStoredExPoint()
		end
	end
end

function FightBuffStoredExPoint:reset()
	self.entity = nil
end

function FightBuffStoredExPoint:dispose()
	self.entity = nil
end

return FightBuffStoredExPoint
