-- chunkname: @modules/logic/fight/model/mo/HeroSpAttributeMO.lua

module("modules.logic.fight.model.mo.HeroSpAttributeMO", package.seeall)

local HeroSpAttributeMO = pureTable("HeroSpAttributeMO")

function HeroSpAttributeMO:init(uid, info)
	self.uid = uid
	self.revive = info.revive
	self.heal = info.heal
	self.absorb = info.absorb
	self.defenseIgnore = info.defenseIgnore
	self.clutch = info.clutch
	self.finalAddDmg = info.finalAddDmg
	self.finalDropDmg = info.finalDropDmg
	self.normalSkillRate = info.normalSkillRate
	self.playAddRate = info.playAddRate
	self.playDropRate = info.playDropRate
	self.dizzyResistances = info.dizzyResistances
	self.sleepResistances = info.sleepResistances
	self.petrifiedResistances = info.petrifiedResistances
	self.frozenResistances = info.frozenResistances
	self.disarmResistances = info.disarmResistances
	self.forbidResistances = info.forbidResistances
	self.sealResistances = info.sealResistances
	self.cantGetExskillResistances = info.cantGetExskillResistances
	self.delExPointResistances = info.delExPointResistances
	self.stressUpResistances = info.stressUpResistances
	self.controlResilience = info.controlResilience
	self.delExPointResilience = info.delExPointResilience
	self.stressUpResilience = info.stressUpResilience
	self.charmResistances = info.charmResistances
end

return HeroSpAttributeMO
