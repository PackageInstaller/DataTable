-- chunkname: @modules/logic/matchgame/fight/model/MatchGameHeroFightMo.lua

module("modules.logic.matchgame.fight.model.MatchGameHeroFightMo", package.seeall)

local MatchGameHeroFightMo = pureTable("MatchGameHeroFightMo")

function MatchGameHeroFightMo:ctor()
	self.id = 0
	self.maxHp = 0
	self.hp = self.maxHp
	self.def = 0
	self.attack = 0
	self.attackRate = 1
	self.heal = 0
	self.maxEnergy = 0
	self.energy = 0
	self.damage = 0
	self.skillId = 0
	self.skillUserType = MatchGameFightEnum.SkillUserType.Hero
	self.skillBuffMoMap = {}
	self.giddyState = false
end

function MatchGameHeroFightMo:initData(data)
	self.heroSingleGroupMo = data.heroSingleGroupMo
	self.id = tonumber(self.heroSingleGroupMo.heroId) or 0

	if self.id == 0 then
		return
	end

	self.config = MatchGameConfig.instance:getCharacterConfig(self.id)
	self.posIndex = data.posIndex
	self.career = self.config.elementId
	self.maxHp = self.heroSingleGroupMo:getAttrValue(MatchGameEnum.CharacterAttrType.Hp)
	self.hp = self.maxHp
	self.attack = self.heroSingleGroupMo:getAttrValue(MatchGameEnum.CharacterAttrType.Atk)
	self.def = self.heroSingleGroupMo:getAttrValue(MatchGameEnum.CharacterAttrType.Def)
	self.heal = self.heroSingleGroupMo:getAttrValue(MatchGameEnum.CharacterAttrType.Heal)

	if not string.nilorempty(self.config.activeSkillId) then
		self.skillId = tonumber(self.config.activeSkillId)

		local skillConfig = MatchGameConfig.instance:getHeroSkillConfig(self.skillId)

		self.maxEnergy = skillConfig.energyCost
		self.energy = skillConfig.initialEnergy or 0
	end

	self.giddyState = false
	self.attackRate = 1
	self.skillAttackRate = 0
	self.damage = 0
end

function MatchGameHeroFightMo:updateFightInfo(info)
	if self.id <= 0 then
		return
	end

	self.maxHp = info.maxHp or self.maxHp
	self.hp = Mathf.Min(info.hp or self.hp, self.maxHp)
	self.def = info.def or self.def
	self.attack = info.attack or self.attack
	self.heal = info.heal or self.heal
	self.energy = Mathf.Min(info.energy or self.energy, self.maxEnergy)
	self.attackRate = info.attackRate or self.attackRate
	self.skillAttackRate = info.skillAttackRate or self.skillAttackRate
	self.damage = info.damage or self.damage
end

function MatchGameHeroFightMo:setGiddyState(state)
	self.giddyState = state
end

return MatchGameHeroFightMo
