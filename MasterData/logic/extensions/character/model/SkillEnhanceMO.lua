-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/character/model/SkillEnhanceMO.lua

module("logic.extensions.character.model.SkillEnhanceMO", package.seeall)

local SkillEnhanceMO = class("SkillEnhanceMO")
local kSharedListCache = {}
local kSharedListCapacity = 5

function SkillEnhanceMO.getSharedMO(skillCode)
	local shared = table.remove(kSharedListCache)

	if shared then
		return shared:setSkillCode(skillCode)
	else
		return SkillEnhanceMO.New(skillCode, true)
	end
end

function SkillEnhanceMO.releaseSharedMO(sharedMO)
	if sharedMO and sharedMO:isShared() and #kSharedListCache < kSharedListCapacity then
		sharedMO:reset()
		table.insert(kSharedListCache, sharedMO)
	end
end

function SkillEnhanceMO:ctor(skillCode, isShared)
	self:setSkillCode(skillCode)

	self._skillEnhanceCodes = {}
	self._addEffectSkillEnhanceCOWrapper = false
	self._description = false
	self._strengthenDesc = false
	self._isShared = isShared
end

function SkillEnhanceMO:isShared()
	return self._isShared
end

function SkillEnhanceMO:setSkillCode(skillCode)
	self._skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillCode or 0)
	self._actionParserList = {}
	self._conditionParseList = {}
	self._modifiedEffectsList = {}
	self._descTagIdDic = {}
	self._descBuffIdDic = {}

	self:_prepareForStatus(BattleEnum.SkillStatus.Normal)

	if self._skillCOWrapper and self._skillCOWrapper:hasStrenthening() then
		self:_prepareForStatus(BattleEnum.SkillStatus.Strenthening)
	end

	self:initPossibleModify(skillCode)

	return self
end

function SkillEnhanceMO:_prepareForStatus(status)
	if not self._actionParserList[status] then
		self._actionParserList[status] = SkillEffectActionParser.New()
		self._conditionParseList[status] = SkillEffectConditionParser.New()
		self._modifiedEffectsList[status] = {}
	else
		self._actionParserList[status]:clear()
		self._conditionParseList[status]:clear()
		BattleTableUtil.clearTable(self._modifiedEffectsList[status])
	end
end

function SkillEnhanceMO:addSkillEnhanceCode(skillEnhanceCode)
	table.insert(self._skillEnhanceCodes, skillEnhanceCode)

	return self
end

function SkillEnhanceMO:addSkillEnhanceCodes(skillEnhanceCodes)
	BattleTableUtil.insertto(self._skillEnhanceCodes, skillEnhanceCodes)

	return self
end

function SkillEnhanceMO:getAllSkillEnhanceCode()
	return self._skillEnhanceCodes
end

function SkillEnhanceMO:getSkillCOWrapper()
	return self._skillCOWrapper
end

function SkillEnhanceMO:getSkillCO()
	return self._skillCOWrapper:getSkillCO()
end

function SkillEnhanceMO:rebuild()
	self:_clearAllResult()
	self:_buildAllEnhanceEffect()
	self:_buildActionParser()
end

function SkillEnhanceMO:reset()
	self:_clearAllResult()

	self._skillCOWrapper = false

	BattleTableUtil.clearTable(self._skillEnhanceCodes)
end

function SkillEnhanceMO:clear()
	self:_clearAllResult()
	BattleTableUtil.clearTable(self._skillEnhanceCodes)
end

function SkillEnhanceMO:getOriginDesc()
	local skillCO = self._skillCOWrapper:getSkillCO()

	if self._addEffectSkillEnhanceCOWrapper then
		local enhaceCO = self._addEffectSkillEnhanceCOWrapper:getSkillEnhanceCO()

		return enhaceCO.newDesc
	else
		return skillCO.normalConfig.desc
	end
end

function SkillEnhanceMO:getFormatDesc(description, tagIds, buffColorStr, modifiedColorStr, isIgnoreColor)
	local desc = ActiveSkillCOUtil.buildBuffAndTagDesc(description, self._descBuffIdDic, self._descTagIdDic, tagIds)
	local wordData = WordUtil.parse(desc)

	desc = wordData and wordData:getDesc() or desc

	return ActiveSkillCOUtil.replaceDescriptionSpecialColor(desc, buffColorStr, modifiedColorStr, isIgnoreColor)
end

function SkillEnhanceMO:getDescriptionSpecifyColor(colorStrModifiedPossible, colorStrPattern)
	local desc = self:getOriginDesc()

	desc = string.gsub(desc, ActiveSkillCOUtil.REGEX_DESC, function(descPatternResult)
		return self:_replaceDescFunction(descPatternResult, colorStrModifiedPossible)
	end)
	desc = self:getFormatDesc(desc, nil, colorStrPattern)

	return desc
end

function SkillEnhanceMO:getDescriptionTagHighLight(tagIds, isIgnoreColor)
	local len = tagIds and #tagIds or 0

	if len == 0 then
		return self:getDescription(isIgnoreColor)
	end

	local description = self:getOriginDesc()

	local function replaceDescFunction(descPatternResult)
		return self:_replaceDescFunction(descPatternResult, nil)
	end

	description = string.gsub(description, ActiveSkillCOUtil.REGEX_DESC, replaceDescFunction)

	return self:getFormatDesc(description, tagIds, nil, nil, isIgnoreColor)
end

function SkillEnhanceMO:getDescription(isIgnoreColor)
	self:buildDescription(isIgnoreColor)

	return self._description
end

function SkillEnhanceMO:getStrengthenDescription()
	self:buildDescription()

	return self._strengthenDesc
end

function SkillEnhanceMO:getReleaseDistanceLabel(status)
	return ActiveSkillCOUtil.getReleaseDistanceLabel(self:getSkillCOWrapper(), self:getReleaseDistance(), status)
end

function SkillEnhanceMO:getReleaseDistance(status)
	status = self._skillCOWrapper:getValidSkillStatus(status)

	return self:_findEffectParams(ActiveSkillCOUtil.FIELD_RELEASE_DISTANCE, status)
end

function SkillEnhanceMO:getTransportDistance(status)
	status = self._skillCOWrapper:getValidSkillStatus(status)

	local distance, key = self._actionParserList[status]:getTransportDistance()
	local enhancedRange = self._modifiedEffectsList[status][key]

	distance = enhancedRange and enhancedRange or distance

	return distance
end

function SkillEnhanceMO:getSecondSelectSelectableTarget(status)
	status = self._skillCOWrapper:getValidSkillStatus(status)

	return self._actionParserList[status]:getSecondSelectSelectableTarget()
end

function SkillEnhanceMO:getMoveAudio(status)
	status = self._skillCOWrapper:getValidSkillStatus(status)

	return self._actionParserList[status]:getMoveAudio()
end

function SkillEnhanceMO:getDeadPerformLost(status)
	status = self._skillCOWrapper:getValidSkillStatus(status)

	return self._actionParserList[status]:getDeadPerformLost()
end

function SkillEnhanceMO:getMultiAOEShape(status)
	status = self._skillCOWrapper:getValidSkillStatus(status)

	local multiAOEAction = self._actionParserList[status]:getMultiAOEParams()

	return multiAOEAction.shape
end

function SkillEnhanceMO:generateSkillRangeShape(status)
	local shapeOfAOE = self:generateAoeShape(status)

	if not shapeOfAOE then
		local shape = self._skillCOWrapper:getSkillRangeShape(status)

		return BattleShapeUtil.createShapeByName(shape.type, shape)
	end

	return shapeOfAOE
end

function SkillEnhanceMO:generateAoeShape(status)
	status = self._skillCOWrapper:getValidSkillStatus(status)

	local originShape, actionIdx = self._actionParserList[status]:getAoeShape()

	if originShape then
		return BattleShapeUtil.createShapeByName(originShape.type, originShape)
	end

	return false
end

function SkillEnhanceMO:getHaloShapeAndRange(status)
	status = self._skillCOWrapper:getValidSkillStatus(status)

	local rangeKey, shapeKey, shape = self._actionParserList[status]:getHaloParams()
	local range = self._modifiedEffectsList[status][rangeKey] or self._skillCOWrapper:getValueByKey(rangeKey, status)

	shape = shape or self._modifiedEffectsList[status][shapeKey] or self._skillCOWrapper:getValueByKey(shapeKey, status)

	return BattleEnum.Shape[shape], range
end

function SkillEnhanceMO:getName()
	local skillCO = self:getSkillCO()

	return skillCO.name
end

function SkillEnhanceMO:isAddEnhanced()
	return self._addEffectSkillEnhanceCOWrapper and true or false
end

function SkillEnhanceMO:getIsPossibleModify(key, status)
	return self._possibleKeyDic[string.format("%s%s", key, status)]
end

function SkillEnhanceMO:initPossibleModify(skillCode)
	self._possibleKeyDic = {}

	local enhanceCodes = ActiveSkillConfig.instance:getEnhanceCodesOfSkill(skillCode)

	for _, enhanceCode in pairs(enhanceCodes) do
		local enhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(enhanceCode)

		for status, _ in pairs(self._actionParserList) do
			local allEnhanceParams = enhanceCOWrapper:getAllEnhanceParams(status)

			if not enhanceCOWrapper:isAddEnhance() then
				for effectKey, value in pairs(allEnhanceParams) do
					self._possibleKeyDic[string.format("%s%s", effectKey, status)] = value
				end
			end
		end
	end
end

function SkillEnhanceMO:_findEffectParams(effectKey, status)
	status = self._skillCOWrapper:getValidSkillStatus(status)

	return self._modifiedEffectsList[status][effectKey] or self._skillCOWrapper:getValueByKey(effectKey, status)
end

function SkillEnhanceMO:_buildAllEnhanceEffect()
	for _, enhanceCode in ipairs(self._skillEnhanceCodes) do
		local enhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(enhanceCode)

		for status, _ in pairs(self._actionParserList) do
			local allEnhanceParams = enhanceCOWrapper:getAllEnhanceParams(status)

			if not enhanceCOWrapper:isAddEnhance() then
				for effectKey, value in pairs(allEnhanceParams) do
					self:_applyModifyInfo(effectKey, value, status)
				end
			else
				self._addEffectSkillEnhanceCOWrapper = enhanceCOWrapper
			end
		end
	end
end

function SkillEnhanceMO:_applyModifyInfo(effectKey, value, status)
	local modified = self._modifiedEffectsList[status][effectKey]

	if not modified then
		self._modifiedEffectsList[status][effectKey] = self._skillCOWrapper:getValueByKey(effectKey, status) + value
	else
		self._modifiedEffectsList[status][effectKey] = self._modifiedEffectsList[status][effectKey] + value
	end
end

function SkillEnhanceMO:buildDescription(isIgnoreColor)
	if self._description then
		return
	end

	local skillCO = self._skillCOWrapper:getSkillCO()

	self._description = self:getOriginDesc()
	self._strengthenDesc = skillCO.hasGodlike and skillCO.godlikeConfig.desc or ""

	local function replaceDescFunction(descPatternResult)
		return self:_replaceDescFunction(descPatternResult, nil)
	end

	self._description = string.gsub(self._description, ActiveSkillCOUtil.REGEX_DESC, replaceDescFunction)
	self._description = self:getFormatDesc(self._description, nil, nil, nil, isIgnoreColor)
	self._strengthenDesc = string.gsub(self._strengthenDesc, ActiveSkillCOUtil.REGEX_DESC, replaceDescFunction)
	self._strengthenDesc = self:getFormatDesc(self._strengthenDesc)
end

function SkillEnhanceMO:_replaceDescFunction(descPatternResult, colorStrModifiedPossible)
	if string.find(descPatternResult, "color=") or string.find(descPatternResult, "/color") then
		return descPatternResult
	end

	local floatValue = 0
	local percentCount = ActiveSkillCOUtil.calculatePercentCount(descPatternResult)
	local matchContent = ActiveSkillCOUtil.getContentFromDescPatternResult(descPatternResult, percentCount)
	local status = string.find(matchContent, "godlike") and BattleEnum.SkillStatus.Strenthening or BattleEnum.SkillStatus.Normal

	if status == BattleEnum.SkillStatus.Strenthening then
		matchContent = string.gsub(matchContent, "godlike", "")
	end

	if string.find(matchContent, "add") then
		floatValue = self._addEffectSkillEnhanceCOWrapper:_getAddEffectValueByKey(matchContent, status)
	else
		floatValue = self._modifiedEffectsList[status] and self._modifiedEffectsList[status][matchContent] and self._modifiedEffectsList[status][matchContent] or self._skillCOWrapper:getValueByKey(matchContent, status)
	end

	if not floatValue then
		printError("技能描述解析失败:", descPatternResult)

		floatValue = 0
	end

	floatValue = ActiveSkillCOUtil.formatValueByPercentCount(floatValue, percentCount)

	local hasModifiedPossibility = self:getIsPossibleModify(matchContent, status)

	if hasModifiedPossibility then
		if string.nilorempty(colorStrModifiedPossible) then
			colorStrModifiedPossible = ActiveSkillCOUtil.PATTERN_MODIFIED_POSSIBLE
		end

		return string.format("<color=%s>%s</color>", colorStrModifiedPossible, floatValue)
	else
		return floatValue
	end
end

function SkillEnhanceMO:_clearAllResult()
	for k, v in pairs(self._modifiedEffectsList) do
		BattleTableUtil.clearTable(v)
	end

	self._addEffectSkillEnhanceCOWrapper = false
	self._description = false
end

function SkillEnhanceMO:_checkAddEffect()
	if not enableDebug then
		return
	end

	if enableErrorLog then
		self:_logError("already has add effect")
	end
end

function SkillEnhanceMO:_buildActionParser()
	local skillCO = self._skillCOWrapper:getSkillCO()

	self:_parseStatusConfig(BattleEnum.SkillStatus.Normal, skillCO.normalConfig)

	if self._skillCOWrapper:hasStrenthening() then
		self:_parseStatusConfig(BattleEnum.SkillStatus.Strenthening, skillCO.godlikeConfig)
	end
end

function SkillEnhanceMO:_parseStatusConfig(status, statusConfig)
	local actionParser = self._actionParserList[status]
	local conditionParser = self._conditionParseList[status]
	local skillEffectList = statusConfig.skillEffectList

	actionParser:clear()

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
end

function SkillEnhanceMO:getDescTagIdList()
	return self._descTagIdDic
end

function SkillEnhanceMO:getDescBuffIdList()
	return self._descBuffIdDic
end

function SkillEnhanceMO:fillTagIdList(tags)
	for tagId, v in pairs(self._descTagIdDic) do
		table.insert(tags, tagId)
	end
end

function SkillEnhanceMO:fillBuffCodesList(buffs)
	for buffId, v in pairs(self._descBuffIdDic) do
		table.insert(buffs, buffId)
	end
end

function SkillEnhanceMO:_logError(...)
	local skillCO = self:getSkillCO()

	printError(string.format("SkillEnhanceMO::error, skill = %s, name = %s, details::", skillCO.code, skillCO.name), ...)
end

return SkillEnhanceMO
