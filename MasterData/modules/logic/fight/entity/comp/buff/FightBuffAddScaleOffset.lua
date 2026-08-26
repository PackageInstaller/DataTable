-- chunkname: @modules/logic/fight/entity/comp/buff/FightBuffAddScaleOffset.lua

module("modules.logic.fight.entity.comp.buff.FightBuffAddScaleOffset", package.seeall)

local FightBuffAddScaleOffset = class("FightBuffAddScaleOffset")

function FightBuffAddScaleOffset:onBuffStart(entity, buffMo)
	local entityId = entity.id

	self.entityId = entityId

	local scaleOffsetDic = FightDataHelper.entityExMgr:getById(entityId).scaleOffsetDic

	scaleOffsetDic.FightBuffAddScaleOffset = 1.3

	local entityData = FightDataHelper.entityMgr:getById(entityId)

	if entityData then
		local _, _, _, scale = FightHelper.getEntityStandPos(entityData)

		entity:setScale(scale)
	end
end

function FightBuffAddScaleOffset:onBuffEnd()
	local entity = FightHelper.getEntity(self.entityId)

	if not entity then
		return
	end

	local entityId = entity.id
	local scaleOffsetDic = FightDataHelper.entityExMgr:getById(entityId).scaleOffsetDic

	scaleOffsetDic.FightBuffAddScaleOffset = nil

	local entityData = FightDataHelper.entityMgr:getById(entityId)

	if entityData then
		local _, _, _, scale = FightHelper.getEntityStandPos(entityData)

		entity:setScale(scale)
	end
end

return FightBuffAddScaleOffset
