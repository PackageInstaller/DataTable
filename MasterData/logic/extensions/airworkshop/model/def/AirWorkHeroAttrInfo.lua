-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkHeroAttrInfo.lua

module("logic.extensions.airworkshop.model.def.AirWorkHeroAttrInfo", package.seeall)

local M = class("AirWorkHeroAttrInfo", AbstractGlobalReusable)

function M:ctor()
	self.level = 0
	self.entityCode = 0
	self.attributes = {}
	self.skills = {}
	self.isCreateByAgent = false
end

function M:reset()
	BattleTableUtil.clearTable(self.attributes)

	for _, skill in pairs(self.skills) do
		skill:returnSelf()
	end

	BattleTableUtil.clearTable(self.skills)

	self.isCreateByAgent = false
end

function M:destroy()
	self:reset()
end

function M:copy(heroAttrInfo)
	self.level = heroAttrInfo.level
	self.entityCode = heroAttrInfo.entityCode

	for k, v in pairs(heroAttrInfo.attributes) do
		self.attributes[k] = v
	end

	for k, v in pairs(heroAttrInfo.skills) do
		self.skills[k] = M.Skill:createInstance(v.skillCode, v.enhanceCodes)
	end

	self.isCreateByAgent = heroAttrInfo.isCreateByAgent
end

function M:initAttrByClient(heroId)
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	self.level = heroMO:getLevel()
	self.entityCode = heroMO:getId()

	local attributeCodes = BattleExtension_pb.Attribute

	for _, attributeCode in pairs(attributeCodes) do
		self:addAttribute(attributeCode, heroMO:getAttribute(attributeCode))
	end

	for i, skill in ipairs(heroMO:getSkills()) do
		self:addSkillFromSkillId(skill.key)
	end

	local characterCO = CharacterConfig.instance:getCharacterItemInfo(heroId)

	if characterCO and characterCO.battleTalent then
		local talentSkills = characterCO.battleTalent

		if #talentSkills > 0 then
			self:addSkillFromSkillId(talentSkills[1])
		end
	end

	self.isCreateByAgent = false
end

function M:initByAgent(entityAttributeNO)
	self.level = entityAttributeNO.level
	self.entityCode = entityAttributeNO.heroId

	for i, v in ipairs(entityAttributeNO.skills) do
		self:addSkillFromSkillNO(v)
	end

	for i, v in ipairs(entityAttributeNO.attributes) do
		self:addAttribute(v.attr, v.value)
	end

	self.isCreateByAgent = true
end

function M:setAttributeIfNil(attributeCode, attributeValue)
	if not self.attributes[attributeCode] then
		self.attributes[attributeCode] = attributeValue
	end
end

function M:addAttribute(attributeCode, attributeValue)
	self.attributes[attributeCode] = attributeValue
end

function M:getAttribute(propertyCode)
	return self.attributes[propertyCode]
end

function M:addSkillFromSkillNO(skillNO)
	local skill = M.Skill:createFromSkillNO(skillNO)

	table.insert(self.skills, skill)
end

function M:addSkillFromSkillId(skillId)
	local skill = M.Skill:createFromSkillId(skillId)

	table.insert(self.skills, skill)
end

function M:toString()
	return self.entityId
end

function M:getCapacity()
	return BattleConst.ObjPoolCapacityMid
end

function M:isSame(entityInfo)
	if not self.isCreateByAgent then
		self:_isDataSame(entityInfo)
	end

	return true
end

function M:_isDataSame(entityInfo)
	if self.level ~= entityInfo.level then
		return false
	end

	for attributeCode, value in pairs(self.attributes) do
		if entityInfo:getAttribute(attributeCode) ~= value and not self:_isIgnoreAttr(attributeCode) then
			printWarn("viking__isDataSame2HeroData_attributeCode", attributeCode, entityInfo:getAttribute(attributeCode), value)

			return false
		end
	end

	local tempDic = BattleTableUtil.getTempList()

	for i, skill in ipairs(self.skills) do
		tempDic[skill.skillCode] = skill
	end

	for i, skill in ipairs(entityInfo.skills) do
		if not tempDic[skill.skillCode] then
			BattleTableUtil.releaseTempList(tempDic)
			printWarn("viking_isSame2HeroData_skill", skill.key)

			return false
		end
	end

	BattleTableUtil.releaseTempList(tempDic)

	return true
end

function M:isSame2HeroData()
	printWarn("viking_isSame2HeroData_isSame2HeroDataStart")

	local heroMO = HeroDepotModel.instance:getHeroInfoByID(self.entityCode)

	if not heroMO then
		printWarn("viking_isSame2HeroData_heroMO", self.entityCode)

		return false
	end

	printWarn("viking_isSame2HeroData_leveltest", self.level, heroMO:getLevel())

	if heroMO:getLevel() ~= self.level then
		printWarn("viking_isSame2HeroData_level", self.level, heroMO:getLevel())

		return false
	end

	for attributeCode, value in pairs(self.attributes) do
		if heroMO:getAttribute(attributeCode) ~= value and not self:_isIgnoreAttr(attributeCode) then
			printWarn("viking_isSame2HeroData_attributeCode", attributeCode, heroMO:getAttribute(attributeCode), value)

			return false
		end
	end

	local tempDic = BattleTableUtil.getTempList()

	for i, skill in ipairs(self.skills) do
		tempDic[skill.skillCode] = skill
	end

	for i, skill in ipairs(heroMO:getSkills()) do
		if not tempDic[skill.key] then
			BattleTableUtil.releaseTempList(tempDic)
			printWarn("viking_isSame2HeroData_skill", skill.key)

			return false
		end
	end

	local characterCO = CharacterConfig.instance:getCharacterItemInfo(self.entityCode)

	if characterCO and characterCO.battleTalent then
		local talentSkills = characterCO.battleTalent

		if #talentSkills > 0 and not tempDic[talentSkills[1]] then
			BattleTableUtil.releaseTempList(tempDic)
			printWarn("viking_isSame2HeroData_talent", talentSkills[1])

			return false
		end
	end

	BattleTableUtil.releaseTempList(tempDic)
	printWarn("viking_isSame2HeroData", true)

	return true
end

function M:_isIgnoreAttr(attributeCode)
	if attributeCode == BattleExtension_pb.Attribute.CURRENT_HP or attributeCode == BattleExtension_pb.Attribute.CURRENT_HP_RATE then
		return true
	end
end

M.Skill = class("M.Skill", AbstractGlobalReusable)

function M.Skill:createFromSkillNO(skillNO)
	local skill = M.Skill:createInstance(skillNO.code, skillNO.enhanced)

	return skill
end

function M.Skill:createFromSkillId(skillId)
	local skill = M.Skill:createInstance(skillId)

	return skill
end

function M.Skill:getCapacity()
	return BattleConst.ObjPoolCapacityMax
end

function M.Skill:ctor(skillCode, enhanceCodes)
	self.skillCode = false
	self.skillCd = false
	self.enhanceCodes = {}
	self.skillSourceType = false
	self.skillSourceEntityId = false

	self:reuse(skillCode, enhanceCodes)
end

function M.Skill:reuse(skillCode, enhanceCodes)
	self.skillCode = skillCode

	if enhanceCodes then
		BattleTableUtil.insertto(self.enhanceCodes, enhanceCodes)
	end
end

function M.Skill:reset()
	self.skillCode = false
	self.skillCd = false

	BattleTableUtil.clearTable(self.enhanceCodes)
end

function M.Skill:toString()
	return self.skillCode
end

return M
