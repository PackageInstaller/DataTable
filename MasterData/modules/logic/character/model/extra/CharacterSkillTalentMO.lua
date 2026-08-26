-- chunkname: @modules/logic/character/model/extra/CharacterSkillTalentMO.lua

module("modules.logic.character.model.extra.CharacterSkillTalentMO", package.seeall)

local CharacterSkillTalentMO = class("CharacterSkillTalentMO")

function CharacterSkillTalentMO:initMo(co)
	self.id = co.talentId
	self.level = co.level
	self.co = co
	self.status = CharacterExtraEnum.SkillTreeNodeStatus.Normal
end

function CharacterSkillTalentMO:getLevel()
	return self.level
end

function CharacterSkillTalentMO:setStatus(status)
	self.status = status
end

function CharacterSkillTalentMO:isLight()
	return self.status == CharacterExtraEnum.SkillTreeNodeStatus.Light
end

function CharacterSkillTalentMO:isLock()
	return self.status == CharacterExtraEnum.SkillTreeNodeStatus.Lock
end

function CharacterSkillTalentMO:isNormal()
	return self.status == CharacterExtraEnum.SkillTreeNodeStatus.Normal
end

function CharacterSkillTalentMO:getIconPath()
	return self.co.icon
end

function CharacterSkillTalentMO:getDesc(exSkillLevel)
	local desc = ""

	if not self.co then
		return desc
	end

	desc = exSkillLevel == 0 and self.co.desc or self.co["desc" .. exSkillLevel]

	if string.nilorempty(desc) then
		return desc
	end

	return desc
end

function CharacterSkillTalentMO:getFieldDesc(exSkillLevel)
	local desc = ""

	if not self.co then
		return desc
	end

	desc = exSkillLevel == 0 and self.co.fieldDesc or self.co["fieldDesc" .. exSkillLevel]

	if string.nilorempty(desc) then
		return desc
	end

	return desc
end

function CharacterSkillTalentMO:getFieldActivateDesc(exSkillLevel)
	local desc = ""

	if not self.co then
		return desc
	end

	desc = exSkillLevel == 0 and self.co.fieldActivateDesc or self.co["fieldActivateDesc" .. exSkillLevel]

	if string.nilorempty(desc) then
		return desc
	end

	return desc
end

function CharacterSkillTalentMO:getAdditionalFieldDesc(exSkillLevel)
	local desc = ""

	if not self.co then
		return desc
	end

	desc = exSkillLevel == 0 and self.co.additionalFieldDesc or self.co["additionalFieldDesc" .. exSkillLevel]

	if string.nilorempty(desc) then
		return desc
	end

	return desc
end

function CharacterSkillTalentMO:getLightNodeAdditionalDesc(exSkillLevel)
	if self:isLight() then
		return self:getAdditionalFieldDesc(exSkillLevel)
	end
end

function CharacterSkillTalentMO:getReplaceSkill(exSkillLevel)
	if not self.co then
		return
	end

	local skill = self.co["exchangeSkills" .. exSkillLevel]

	if string.nilorempty(skill) then
		return
	end

	return (GameUtil.splitString2(skill, true, "|", "#"))
end

return CharacterSkillTalentMO
