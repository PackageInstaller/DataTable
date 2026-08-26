-- chunkname: @modules/logic/character/model/extra/CharacterExtraMO.lua

module("modules.logic.character.model.extra.CharacterExtraMO", package.seeall)

local CharacterExtraMO = class("CharacterExtraMO")

function CharacterExtraMO:ctor(heroMo)
	self.heroMo = heroMo
end

function CharacterExtraMO:refreshMo(extraStr)
	self._extra = {}

	if self:hasTalentSkill() then
		self._skillTalentMo = self._skillTalentMo or CharacterExtraSkillTalentMO.New()

		self._skillTalentMo:refreshMo(extraStr, self.heroMo)
	end

	if self:hasWeapon() then
		self._weaponMo = self._weaponMo or CharacterExtraWeaponMO.New()

		self._weaponMo:refreshMo(extraStr, self.heroMo)
	end
end

function CharacterExtraMO:hasTalentSkill()
	return self.heroMo.heroId == 3124
end

function CharacterExtraMO:hasWeapon()
	return self.heroMo.heroId == 3123
end

function CharacterExtraMO:getSkillTalentMo()
	return self._skillTalentMo
end

function CharacterExtraMO:getWeaponMo()
	return self._weaponMo
end

function CharacterExtraMO:showReddot()
	if self._skillTalentMo then
		return self._skillTalentMo:showReddot()
	end

	if self._weaponMo then
		for type, _ in ipairs(CharacterExtraEnum.WeaponParams) do
			local isShow = self._weaponMo:isShowWeaponReddot(type)

			if isShow then
				return true
			end
		end
	end
end

function CharacterExtraMO:getReplaceSkills(skillIdList)
	if self._weaponMo then
		skillIdList = self._weaponMo:getReplacePassiveSkills(skillIdList)
	end

	if self._skillTalentMo then
		skillIdList = self._skillTalentMo:getReplaceSkills(skillIdList)
	end

	return skillIdList
end

return CharacterExtraMO
