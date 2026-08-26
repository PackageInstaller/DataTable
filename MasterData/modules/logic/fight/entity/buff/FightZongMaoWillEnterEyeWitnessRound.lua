-- chunkname: @modules/logic/fight/entity/buff/FightZongMaoWillEnterEyeWitnessRound.lua

module("modules.logic.fight.entity.buff.FightZongMaoWillEnterEyeWitnessRound", package.seeall)

local FightZongMaoWillEnterEyeWitnessRound = class("FightZongMaoWillEnterEyeWitnessRound", FightBaseClass)

function FightZongMaoWillEnterEyeWitnessRound:onConstructor(buffData)
	self.buffData = buffData
	self.uid = buffData.uid
	self.entityId = buffData.entityId
	self.buffId = buffData.buffId
	self.entityData = FightDataHelper.entityMgr:getById(self.entityId)
end

function FightZongMaoWillEnterEyeWitnessRound:onDestructor()
	return
end

return FightZongMaoWillEnterEyeWitnessRound
