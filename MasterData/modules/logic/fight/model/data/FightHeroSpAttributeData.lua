-- chunkname: @modules/logic/fight/model/data/FightHeroSpAttributeData.lua

module("modules.logic.fight.model.data.FightHeroSpAttributeData", package.seeall)

local FightHeroSpAttributeData = FightDataClass("FightHeroSpAttributeData")

function FightHeroSpAttributeData:onConstructor(proto)
	self.revive = proto.revive
	self.heal = proto.heal
	self.absorb = proto.absorb
	self.defenseIgnore = proto.defenseIgnore
	self.clutch = proto.clutch
	self.finalAddDmg = proto.finalAddDmg
	self.finalDropDmg = proto.finalDropDmg
	self.normalSkillRate = proto.normalSkillRate
	self.playAddRate = proto.playAddRate
	self.playDropRate = proto.playDropRate
	self.dizzyResistances = proto.dizzyResistances
	self.sleepResistances = proto.sleepResistances
	self.petrifiedResistances = proto.petrifiedResistances
	self.frozenResistances = proto.frozenResistances
	self.disarmResistances = proto.disarmResistances
	self.forbidResistances = proto.forbidResistances
	self.sealResistances = proto.sealResistances
	self.cantGetExskillResistances = proto.cantGetExskillResistances
	self.delExPointResistances = proto.delExPointResistances
	self.stressUpResistances = proto.stressUpResistances
	self.controlResilience = proto.controlResilience
	self.delExPointResilience = proto.delExPointResilience
	self.stressUpResilience = proto.stressUpResilience
	self.charmResistances = proto.charmResistances
	self.reboundDmg = proto.reboundDmg
	self.extraDmg = proto.extraDmg
	self.reuseDmg = proto.reuseDmg
	self.bigSkillRate = proto.bigSkillRate
end

return FightHeroSpAttributeData
