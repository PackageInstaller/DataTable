-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/ActiveSkillCOWrapper.lua

module("logic.battle.config.ActiveSkillCOWrapper", package.seeall)

local ActiveSkillCOWrapper = class("ActiveSkillCOWrapper")

function ActiveSkillCOWrapper:ctor(skillCO)
	self._skillCO = skillCO
	self._description = false
	self._mainAnimStateList = {}
	self._actionParserList = {}
	self._conditionParseList = {}
	self._effectParamsTableList = {}
	self._possibleModifiedEffectTableList = {}

	self:_parseAllEffectParams()
end

function ActiveSkillCOWrapper:getSkillCode()
	return self._skillCO.code
end

function ActiveSkillCOWrapper:getSkillCO()
	return self._skillCO
end

function ActiveSkillCOWrapper:getName()
	return self._skillCO.name
end

function ActiveSkillCOWrapper:getDescription()
	if not self._description then
		local skillEnhanceMO = SkillEnhanceMO.getSharedMO(self:getSkillCode())

		self._description = skillEnhanceMO:getDescription()

		SkillEnhanceMO.releaseSharedMO(skillEnhanceMO)
	end

	return self._description
end

function ActiveSkillCOWrapper:getDescTagIdDic()
	if not self._descTagIdDic then
		local skillEnhanceMO = SkillEnhanceMO.getSharedMO(self:getSkillCode())

		skillEnhanceMO:getDescription()

		self._descTagIdDic = skillEnhanceMO:getDescTagIdList()

		SkillEnhanceMO.releaseSharedMO(skillEnhanceMO)
	end

	return self._descTagIdDic
end

function ActiveSkillCOWrapper:getDescriptionHighLightTag(tagIds)
	if tagIds and #tagIds > 0 then
		local skillEnhanceMO = SkillEnhanceMO.New(self:getSkillCode())
		local desc = skillEnhanceMO:getDescriptionTagHighLight(tagIds)

		return desc
	end

	return ActiveSkillCOWrapper:getDescription()
end

function ActiveSkillCOWrapper:getTalentSkillDesc(status)
	if self:getSkillType(status) == BattleEnum.SkillCategory.TALENT then
		local config = self:_getValidSkillConfig(status)

		return config.backupDesc
	end

	return ""
end

function ActiveSkillCOWrapper:hasStrenthening()
	return self._skillCO.hasGodlike
end

function ActiveSkillCOWrapper:getStrenthenTag()
	return self._skillCO.strengthenTag
end

function ActiveSkillCOWrapper:getAoeType(status)
	local config = self:_getValidSkillConfig(status)

	return config.aoeType
end

function ActiveSkillCOWrapper:getValidSkillStatus(status)
	if status == BattleEnum.SkillStatus.Strenthening and self:hasStrenthening() then
		return BattleEnum.SkillStatus.Strenthening
	end

	return BattleEnum.SkillStatus.Normal
end

function ActiveSkillCOWrapper:getCd()
	return self._skillCO.cd
end

function ActiveSkillCOWrapper:getCareer(status)
	local config = self:_getValidSkillConfig(status)

	return config.career
end

function ActiveSkillCOWrapper:getDisplayCategory(status)
	local config = self:_getValidSkillConfig(status)

	return config.displayCategory
end

function ActiveSkillCOWrapper:getSkillType(status)
	local config = self:_getValidSkillConfig(status)

	return config.skillType
end

function ActiveSkillCOWrapper:getReleaseDistance(status)
	local config = self:_getValidSkillConfig(status)

	return config.releaseDistance
end

function ActiveSkillCOWrapper:getSkillEffectType(status)
	local config = self:_getValidSkillConfig(status)

	return config.skillEffectType
end

function ActiveSkillCOWrapper:getSelectableTarget(status)
	local config = self:_getValidSkillConfig(status)

	return config.selectableTarget
end

function ActiveSkillCOWrapper:getReleaseSkillType(status)
	local config = self:_getValidSkillConfig(status)

	return config.releaseSkillType
end

function ActiveSkillCOWrapper:getPerformanceAnimType(status)
	local config = self:_getValidSkillConfig(status)

	return config.animType
end

function ActiveSkillCOWrapper:getTagString(status)
	local config = self:_getValidSkillConfig(status)

	return config.tag
end

function ActiveSkillCOWrapper:getMainAnimState(status)
	if status == BattleEnum.SkillStatus.Strenthening and self:hasStrenthening() then
		return self._mainAnimStateList[BattleEnum.SkillStatus.Strenthening]
	end

	return self._mainAnimStateList[BattleEnum.SkillStatus.Normal]
end

function ActiveSkillCOWrapper:getCounteredAnimState(status)
	local config = self:_getValidSkillConfig(status)

	return string.nilorempty(config.animState) and self:getMainAnimState(status) or config.animState
end

function ActiveSkillCOWrapper:getSpecialAttackedCode(status)
	local config = self:_getValidSkillConfig(status)

	return config.animState and checkint(config.animState) or 0
end

function ActiveSkillCOWrapper:_getValidSkillConfig(status)
	if status == BattleEnum.SkillStatus.Strenthening and self:hasStrenthening() then
		return self._skillCO.godlikeConfig
	else
		return self._skillCO.normalConfig
	end
end

function ActiveSkillCOWrapper:getTagCodes()
	local tagList = {}

	for k, v in pairs(self._actionParserList) do
		local tags = v:getTagCodes()

		for i1, tag in ipairs(tags) do
			table.insert(tagList, tag)
		end
	end

	local tempTags = {}

	for i, v in ipairs(tagList) do
		tempTags[v] = true
	end

	table.clear(tagList)

	for tag, _ in pairs(tempTags) do
		table.insert(tagList, tag)
	end

	return tagList
end

function ActiveSkillCOWrapper:getAddBuffCodes()
	local addBuffs = {}

	for k, v in pairs(self._actionParserList) do
		local buffs = v:getAddBuffCodes()

		for i1, buff in ipairs(buffs) do
			table.insert(addBuffs, buff)
		end
	end

	for k, v in pairs(self._conditionParseList) do
		local buffs = v:getBuffCodes()

		for i1, buff in ipairs(buffs) do
			table.insert(addBuffs, buff)
		end
	end

	local tempBuffs = {}

	for i, v in ipairs(addBuffs) do
		tempBuffs[v] = true
	end

	table.clear(addBuffs)

	for buff, _ in pairs(tempBuffs) do
		table.insert(addBuffs, buff)
	end

	return addBuffs
end

function ActiveSkillCOWrapper:getWeakPointParams(status)
	status = self:getValidSkillStatus(status)

	return self._actionParserList[status]:getWeakPointParams()
end

function ActiveSkillCOWrapper:getEntityLinkedWeakPointParams(status)
	status = self:getValidSkillStatus(status)

	return self._actionParserList[status]:getEntityLinkedWeakPointParams()
end

function ActiveSkillCOWrapper:getHaloParams(status)
	status = self:getValidSkillStatus(status)

	return self._actionParserList[status]:getHaloParams()
end

function ActiveSkillCOWrapper:getMultiAOEParams(status)
	status = self:getValidSkillStatus(status)

	return self._actionParserList[status]:getMultiAOEParams()
end

function ActiveSkillCOWrapper:hasUnitRelatedTransport(status)
	status = self:getValidSkillStatus(status)

	return self._actionParserList[status]:hasUnitRelatedTransport()
end

function ActiveSkillCOWrapper:getTransportDistance(status)
	status = self:getValidSkillStatus(status)

	return self._actionParserList[status]:getTransportDistance()
end

function ActiveSkillCOWrapper:getSecondSelectSelectableTarget(status)
	status = self:getValidSkillStatus(status)

	return self._actionParserList[status]:getSecondSelectSelectableTarget()
end

function ActiveSkillCOWrapper:getMoveAudio(status)
	status = self:getValidSkillStatus(status)

	return self._actionParserList[status]:getMoveAudio()
end

function ActiveSkillCOWrapper:getDeadPerformLost(status)
	status = self:getValidSkillStatus(status)

	return self._actionParserList[status]:getDeadPerformLost()
end

function ActiveSkillCOWrapper:getSkillRangeShape(status)
	local shape = self:getAoeShape(status)

	if not shape then
		local config = self:_getValidSkillConfig(status)

		shape = config.shape
	end

	return shape
end

function ActiveSkillCOWrapper:getAoeShape(status)
	status = self:getValidSkillStatus(status)

	return self._actionParserList[status]:getAoeShape()
end

function ActiveSkillCOWrapper:getShapeByTagShape(status)
	status = self:getValidSkillStatus(status)

	local aoeShape = self._actionParserList[status]:getAoeShape()

	if aoeShape and aoeShape.shapes then
		return aoeShape.shapes
	end

	return false
end

function ActiveSkillCOWrapper:findEffectParams(effectName, status)
	status = self:getValidSkillStatus(status)

	return self._effectParamsTableList[status][effectName]
end

function ActiveSkillCOWrapper:hasModifiedPossibility(effectName, index, status)
	status = self:getValidSkillStatus(status)

	local indexFlags = self._possibleModifiedEffectTableList[status][effectName]

	if ActiveSkillCOUtil.isModifiableField(effectName) then
		return indexFlags
	end

	return indexFlags and indexFlags[index]
end

function ActiveSkillCOWrapper:_parseAllEffectParams()
	local skillCO = self._skillCO

	self:_prepareForSkillStatus(BattleEnum.SkillStatus.Normal)
	self:_parseStatusSkillConfig(BattleEnum.SkillStatus.Normal, skillCO.normalConfig)

	if self:hasStrenthening() then
		self:_prepareForSkillStatus(BattleEnum.SkillStatus.Strenthening)
		self:_parseStatusSkillConfig(BattleEnum.SkillStatus.Strenthening, skillCO.godlikeConfig)
	end
end

function ActiveSkillCOWrapper:_prepareForSkillStatus(status)
	self._actionParserList[status] = SkillEffectActionParser.New()
	self._conditionParseList[status] = SkillEffectConditionParser.New()
	self._effectParamsTableList[status] = {}
	self._possibleModifiedEffectTableList[status] = {}
end

function ActiveSkillCOWrapper:_parseStatusSkillConfig(status, skillStatusConfig)
	local actionParser = self._actionParserList[status]
	local conditionParser = self._conditionParseList[status]
	local skillEffectList = skillStatusConfig.skillEffectList

	for index, skillEffect in ipairs(skillEffectList) do
		if #skillEffect.actionList ~= 0 then
			for actionIndex, action in ipairs(skillEffect.actionList) do
				actionParser:parseActionParams(action, index, actionIndex)
			end
		end

		if #skillEffect.conditionList ~= 0 then
			for conditionIdx, condition in ipairs(skillEffect.conditionList) do
				conditionParser:parseParams(condition, index, conditionIdx)
			end
		end
	end

	local skillEffect = skillEffectList[1]

	if skillEffect then
		self._mainAnimStateList[status] = skillEffect.timelineRes
	end
end

function ActiveSkillCOWrapper:getValueByKey(keyStr, status)
	local skillConfig = status == BattleEnum.SkillStatus.Strenthening and self._skillCO.godlikeConfig or self._skillCO.normalConfig

	if keyStr == "sanityConsume" then
		return skillConfig.sanityConsume
	elseif keyStr == "releaseDistance" then
		return skillConfig.releaseDistance
	else
		local strList = string.split(keyStr, "_")
		local effectIndex = checkint(string.split(strList[1], "-")[2])
		local actionOrConditionIndex = checkint(string.split(strList[2], "-")[2])
		local paramList = {}

		for i = 3, #strList do
			local strs = string.split(strList[i], "-")

			table.insert(paramList, strs[1])

			if #strs > 1 then
				table.insert(paramList, checkint(strs[2]))
			end
		end

		if string.find(strList[2], "action") then
			local temp = skillConfig.skillEffectList[effectIndex]

			temp = temp and temp.actionList and temp.actionList[actionOrConditionIndex] and temp.actionList[actionOrConditionIndex] or {}

			for i, v in ipairs(paramList) do
				temp = temp and temp[v] or ""
			end

			return temp
		elseif string.find(strList[2], "condition") then
			local temp = skillConfig.skillEffectList[effectIndex].conditionList[actionOrConditionIndex]

			for i, v in ipairs(paramList) do
				temp = temp[v]
			end

			return temp
		else
			printError("问题配置keyStr", keyStr, strList[2])
		end
	end
end

return ActiveSkillCOWrapper
