-- chunkname: @modules/logic/character/model/extra/CharacterSkillTalentTreeMO.lua

module("modules.logic.character.model.extra.CharacterSkillTalentTreeMO", package.seeall)

local CharacterSkillTalentTreeMO = class("CharacterSkillTalentTreeMO")

function CharacterSkillTalentTreeMO:initMo(sub, coList)
	self._sub = sub
	self._moList = BaseModel.New()

	local list = {}

	if coList then
		for _, co in ipairs(coList) do
			local mo = CharacterSkillTalentMO.New()

			mo:initMo(co)
			table.insert(list, mo)
		end
	end

	self._moList:setList(list)
end

function CharacterSkillTalentTreeMO:getTreeMoList()
	return self._moList:getList()
end

function CharacterSkillTalentTreeMO:getMoById(id)
	return self._moList:getById(id)
end

function CharacterSkillTalentTreeMO:getNodeMoByLevel(level)
	for _, mo in ipairs(self._moList:getList()) do
		if mo.level == level then
			return mo
		end
	end
end

function CharacterSkillTalentTreeMO:isAllLight()
	for _, mo in ipairs(self._moList:getList()) do
		if not mo:isLight() then
			return false
		end
	end

	return true
end

function CharacterSkillTalentTreeMO:getLightNodeAdditionalDesc(exSkillLevel)
	local desc = ""
	local level = 0

	for _, mo in ipairs(self._moList:getList()) do
		local _desc = mo:getLightNodeAdditionalDesc(exSkillLevel)

		if not string.nilorempty(_desc) and level < mo.level then
			desc = _desc
		end
	end

	return desc
end

return CharacterSkillTalentTreeMO
