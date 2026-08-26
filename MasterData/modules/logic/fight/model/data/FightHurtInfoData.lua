-- chunkname: @modules/logic/fight/model/data/FightHurtInfoData.lua

module("modules.logic.fight.model.data.FightHurtInfoData", package.seeall)

local FightHurtInfoData = FightDataClass("FightHurtInfoData")

FightHurtInfoData.DamageFromType = {
	AbsorbHurt = 5,
	Skill = 1,
	Buff = 3,
	Additional = 4,
	ShareHurt = 6,
	SkillEffect = 2,
	NONE = 0
}

local criticalType = {
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.ORIGINCRIT] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = true
}

FightHurtInfoData.ImmunityFromType = {
	Narcissus = 1,
	None = 0
}

function FightHurtInfoData:onConstructor(proto)
	self:initClientField()

	self.damage = proto.damage
	self.reduceHp = proto.reduceHp
	self.careerRestraint = proto.careerRestraint
	self.critical = criticalType[proto.hurtEffect]
	self.assassinate = proto.assassinate
	self.hurtEffect = proto.hurtEffect
	self.damageFromType = proto.damageFromType
	self.configEffect = proto.configEffect
	self.buffActId = proto.buffActId
	self.buffUid = proto.buffUid
	self.effectId = proto.effectId
	self.skillId = proto.skillId

	if proto:HasField("fromUid") then
		self.fromUid = proto.fromUid
	end

	self.toughnessValue = proto.toughnessValue
	self.toughnessPoint = proto.toughnessPoint
	self.broken = proto.broken
	self.absorbHurtParam = proto.absorbHurtParam
	self.reduceShield = 0
	self.reduceTeamShareShield = 0
	self.hurtMergeFlag = proto.hurtMergeFlag
	self.immunityFromType = proto.immunityFromType
end

function FightHurtInfoData:initClientField()
	self.client_damageRate = 0
	self.client_floatNum = 0
	self.client_reduceHp = 0
	self.client_reduceShield = 0
	self.client_reduceTeamShareShield = 0
	self.client_yamiShieldPlayUIEffect = false
end

return FightHurtInfoData
