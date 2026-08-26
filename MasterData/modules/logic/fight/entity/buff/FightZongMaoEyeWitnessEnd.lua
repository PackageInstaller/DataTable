-- chunkname: @modules/logic/fight/entity/buff/FightZongMaoEyeWitnessEnd.lua

module("modules.logic.fight.entity.buff.FightZongMaoEyeWitnessEnd", package.seeall)

local FightZongMaoEyeWitnessEnd = class("FightZongMaoEyeWitnessEnd", FightBaseClass)

function FightZongMaoEyeWitnessEnd:onConstructor(buffData)
	self.buffData = buffData
	self.uid = buffData.uid
	self.entityId = buffData.entityId
	self.buffId = buffData.buffId
	self.entityData = FightDataHelper.entityMgr:getById(self.entityId)
end

function FightZongMaoEyeWitnessEnd:onDestructor()
	return
end

return FightZongMaoEyeWitnessEnd
