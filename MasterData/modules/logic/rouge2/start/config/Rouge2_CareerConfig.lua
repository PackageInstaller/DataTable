-- chunkname: @modules/logic/rouge2/start/config/Rouge2_CareerConfig.lua

module("modules.logic.rouge2.start.config.Rouge2_CareerConfig", package.seeall)

local Rouge2_CareerConfig = class("Rouge2_CareerConfig", BaseConfig)

function Rouge2_CareerConfig:onInit()
	return
end

function Rouge2_CareerConfig:reqConfigNames()
	return {
		"rouge2_career",
		"rouge2_career_transfer",
		"rouge2_dice",
		"rouge2_dice_check",
		"fight_rouge2_summoner",
		"rouge2_system"
	}
end

function Rouge2_CareerConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge2_career" then
		self:_onCareerConfigLoaded(configTable)
	elseif configName == "rouge2_career_transfer" then
		self:_onCareerTransferConfigLoaded(configTable)
	elseif configName == "fight_rouge2_summoner" then
		self:_onFightRouge2SummonerConfigLoaded(configTable)
	elseif configName == "rouge2_system" then
		self:_onSystemConfigLoaded(configTable)
	end
end

function Rouge2_CareerConfig:_onCareerConfigLoaded(configTable)
	self._carrerId2PassiveIdMap = {}
	self._careerId2ActiveSkillMap = {}
	self._careerId2AttributeIdMap = {}
	self._careerId2RecommendTeamMap = {}
	self._careerRecommendAttrMap = {}
	self._careerRecommendAttrList = {}

	for _, careerCo in ipairs(configTable.configList) do
		local passiveSkillMap = {}
		local skillList = GameUtil.splitString2(careerCo.passiveSkills, true)

		for _, passiveSkill in ipairs(skillList or {}) do
			local attributeId = passiveSkill[1]

			passiveSkillMap[attributeId] = passiveSkill[2]
		end

		self._carrerId2PassiveIdMap[careerCo.id] = passiveSkillMap
		self._careerId2ActiveSkillMap[careerCo.id] = string.splitToNumber(careerCo.activeSkills, "#")
		self._careerId2AttributeIdMap[careerCo.id] = GameUtil.splitString2(careerCo.initialAttribute, true)
		self._careerId2RecommendTeamMap[careerCo.id] = string.splitToNumber(careerCo.recommendTeam, "#")

		self:_initCareerRecommendAttrInfo(careerCo)
	end
end

function Rouge2_CareerConfig:_initCareerRecommendAttrInfo(careerCo)
	local careerId = careerCo.id

	if careerCo then
		if not careerCo.recommendAttribute then
			local attrStr = ""
			local attrIdList = string.splitToNumber(attrStr, "|") or {}

			self._careerRecommendAttrList[careerId] = attrIdList
			self._careerRecommendAttrMap[careerId] = {}

			for _, attrId in ipairs(attrIdList) do
				self._careerRecommendAttrMap[careerId][attrId] = true
			end
		end
	end
end

function Rouge2_CareerConfig:_onCareerTransferConfigLoaded(configTable)
	self._mainId2TransferCareerMap = {}

	for _, careerCo in ipairs(configTable.configList) do
		local mainCareerId = careerCo.career

		self._mainId2TransferCareerMap[mainCareerId] = self._mainId2TransferCareerMap[mainCareerId] or {}

		table.insert(self._mainId2TransferCareerMap[mainCareerId], careerCo)
	end
end

function Rouge2_CareerConfig:_onFightRouge2SummonerConfigLoaded(configTable)
	self._type2TalentList = {}
	self._nextTalentMap = {}
	self._preTalentMap = {}
	self._holeIndex2TalentMap = {}
	self._stage2TalentList = {}
	self._talentIconUrlMap = {}

	for _, talentCo in ipairs(configTable.configList) do
		local talentId = talentCo.talentId
		local type = talentCo.type

		self._type2TalentList[type] = self._type2TalentList[type] or {}

		table.insert(self._type2TalentList[type], talentCo)

		local keys = string.splitToNumber(talentCo.keys, "#")

		if keys then
			self._preTalentMap[talentId] = {}

			for _, keyId in ipairs(keys) do
				local keyTalentCo = lua_fight_rouge2_summoner.configDict[keyId]

				table.insert(self._preTalentMap[talentId], keyTalentCo)

				self._nextTalentMap[keyId] = self._nextTalentMap[keyId] or {}

				table.insert(self._nextTalentMap[keyId], talentCo)
			end
		end

		if talentCo.ordinal and talentCo.ordinal ~= 0 then
			self._holeIndex2TalentMap[talentCo.ordinal] = talentCo
		end

		self._stage2TalentList[talentCo.stage] = self._stage2TalentList[talentCo.stage] or {}

		table.insert(self._stage2TalentList[talentCo.stage], talentCo)

		local iconUrlStr = string.split(talentCo.icon, "#")

		if iconUrlStr then
			self._talentIconUrlMap[talentId] = {}

			for status, iconUrl in ipairs(iconUrlStr) do
				self._talentIconUrlMap[talentId][status] = iconUrl
			end
		end
	end

	for _, talentList in pairs(self._type2TalentList) do
		table.sort(talentList, self._talentConfigSortFunc)
	end
end

function Rouge2_CareerConfig._talentConfigSortFunc(aTalentCo, bTalentCo)
	local aStage = aTalentCo.stage
	local bStage = bTalentCo.stage

	if aStage ~= bStage then
		return aStage < bStage
	end

	return aTalentCo.talentId < bTalentCo.talentId
end

function Rouge2_CareerConfig:_onSystemConfigLoaded(configTable)
	self._systemRecommendAttrList = {}
	self._systemRecommendAttrMap = {}

	for _, systemCo in ipairs(configTable.configList) do
		self:_initSystemRecommendAttrInfo(systemCo)
	end
end

function Rouge2_CareerConfig:_initSystemRecommendAttrInfo(systemCo)
	local systemId = systemCo.id

	if systemCo then
		if not systemCo.recommendAttribute then
			local attrStr = ""
			local attrIdList = string.splitToNumber(attrStr, "|") or {}

			self._systemRecommendAttrList[systemId] = attrIdList
			self._systemRecommendAttrMap[systemId] = {}

			for _, attrId in ipairs(attrIdList) do
				self._systemRecommendAttrMap[systemId][attrId] = true
			end
		end
	end
end

function Rouge2_CareerConfig:getCareerConfig(careerId)
	local careerCo = lua_rouge2_career.configDict[careerId]

	careerCo = careerCo or lua_rouge2_career_transfer.configDict[careerId]

	if not careerCo then
		logError(string.format("肉鸽职业配置为空 careerId = %s", careerId))

		return
	end

	return careerCo
end

function Rouge2_CareerConfig:mainCareerId2TransferCareerConfigs(mainCareerId)
	if self._mainId2TransferCareerMap then
		if not self._mainId2TransferCareerMap then
			logError(string.format("肉鸽转职配置不存在 mainCareerId = %s", mainCareerId))
		end

		return self._mainId2TransferCareerMap
	end
end

function Rouge2_CareerConfig:getCareerInitialAttributeConfigAndValue(careerId)
	local attrBaseInfoList = {}
	local careerCo = self:getCareerConfig(careerId)

	if careerCo then
		if not careerCo.initialAttribute then
			local initialAttribute = ""

			if string.nilorempty(initialAttribute) then
				logError(string.format("肉鸽职业初始属性配置为空 careerId = %s", careerId))

				return {}
			end

			local attributeList = GameUtil.splitString2(initialAttribute, true)

			for _, list in ipairs(attributeList) do
				local attrId = list[1]
				local attrValue = list[2]

				table.insert(attrBaseInfoList, {
					attrId = attrId,
					value = attrValue
				})
			end

			return attrBaseInfoList
		end
	end
end

function Rouge2_CareerConfig:getCareerInitialAttributeId(careerId)
	local attributeIdList = {}

	if self._careerId2AttributeIdMap then
		if self._careerId2AttributeIdMap then
			for _, attributeInfo in ipairs(self._careerId2AttributeIdMap) do
				table.insert(attributeIdList, attributeInfo[1])
			end
		end

		return attributeIdList
	end
end

function Rouge2_CareerConfig:getAttrSortIndex(careerId, attrId)
	if self._sortAttrIdMap then
		local sortAttrMap = self._sortAttrIdMap[careerId]

		if not self._sortAttrIdMap then
			local careerCo = self:getCareerConfig(careerId)
			local sortAttributeStr = careerCo and careerCo.sortAttribute
			local sortAttrList = GameUtil.splitString2(sortAttributeStr, true)

			sortAttrMap = {}

			for _, sortAttrInfo in ipairs(sortAttrList) do
				local attrId = sortAttrInfo[1]

				self._sortAttrIdMap[attrId] = sortAttrInfo[2]
			end

			self._sortAttrIdMap = self._sortAttrIdMap or {}
			self._sortAttrIdMap[careerId] = self._sortAttrIdMap
		end

		return (self._sortAttrIdMap or nil) and (self._sortAttrIdMap[attrId] or 0)
	end
end

function Rouge2_CareerConfig:getCareerRecommendAttrList(careerId)
	if not careerId then
		return
	end

	return self._careerRecommendAttrList and self._careerRecommendAttrList[careerId]
end

function Rouge2_CareerConfig:isCareerRecommendAttr(careerId, attrId)
	if not careerId or not attrId then
		return
	end

	if self._careerRecommendAttrMap then
		local attrMap = self._careerRecommendAttrMap[careerId]

		return attrMap and attrMap[attrId] == true
	end
end

function Rouge2_CareerConfig:getSystemRecommendAttrMap(systemId)
	if not systemId then
		return
	end

	return self._systemRecommendAttrMap and self._systemRecommendAttrMap[systemId]
end

function Rouge2_CareerConfig:getSystemRecommendAttrList(systemId)
	if not systemId then
		return
	end

	return self._systemRecommendAttrList and self._systemRecommendAttrList[systemId]
end

function Rouge2_CareerConfig:isSystemRecommendAttr(systemId, attrId)
	if not attrId then
		return
	end

	local attrMap = self:getSystemRecommendAttrMap(systemId)

	return attrMap and attrMap[attrId] == true
end

function Rouge2_CareerConfig:getCareerRecommendTeamStr(careerId)
	local careerCo = self:getCareerConfig(careerId)

	return careerCo and careerCo.recommendTeam
end

function Rouge2_CareerConfig:getAllCareerConfigs()
	return lua_rouge2_career.configList
end

function Rouge2_CareerConfig:getCareerPassiveSkillIdMap(careerId)
	if self._carrerId2PassiveIdMap then
		if not self._carrerId2PassiveIdMap then
			logError(string.format("肉鸽职业没有特性技能 careerId = %s", careerId))
		end

		return self._carrerId2PassiveIdMap
	end
end

function Rouge2_CareerConfig:getCareerPassiveSkillId(careerId, attributeId)
	local skillMap = self:getCareerPassiveSkillIdMap(careerId)
	local skillId = skillMap and skillMap[attributeId]

	if not skillId then
		logError(string.format("肉鸽职业属性特性技能不存在 careerId = %s, attributeId = %s", careerId, attributeId))
	end

	return skillId
end

function Rouge2_CareerConfig:getCareerActiveSkillIds(careerId)
	if self._careerId2ActiveSkillMap then
		if not self._careerId2ActiveSkillMap then
			logError(string.format("肉鸽职业没有主动技能 careerId = %s", careerId))
		end

		return self._careerId2ActiveSkillMap
	end
end

function Rouge2_CareerConfig:getCareerInitialColletions(careerId)
	local careerCo = self:getCareerConfig(careerId)

	if not careerCo then
		return {}
	end

	return string.splitToNumber(careerCo.initialColletions, "#")
end

function Rouge2_CareerConfig:getDiceCheckConfig(checkId, checkResult)
	local checkList = lua_rouge2_dice_check.configDict[checkId]
	local checkCo = checkList and checkList[checkResult]

	if not checkCo then
		logError(string.format("肉鸽检定配置不存在 checkId = %s, checkResult = %s", checkId, checkResult))
	end

	return checkCo
end

function Rouge2_CareerConfig:getDicePointList(diceId)
	local diceCo = lua_rouge2_dice.configDict[diceId]

	if not diceCo then
		logError(string.format("肉鸽骰子配置不存在 diceId = %s", diceId))
	end

	return diceCo and GameUtil.splitString2(diceCo.point, true)
end

function Rouge2_CareerConfig:getTalentConfig(talentId)
	local talentCo = lua_fight_rouge2_summoner.configDict[talentId]

	if not talentCo then
		logError(string.format("肉鸽局内天赋点配置不存在 talentId = %s", talentId))
	end

	return talentCo
end

function Rouge2_CareerConfig:getTalentListByType(talentType)
	if self._type2TalentList then
		return self._type2TalentList
	end
end

function Rouge2_CareerConfig:getPreTalentList(talentId)
	if self._preTalentMap then
		return self._preTalentMap
	end
end

function Rouge2_CareerConfig:getNextTalentList(talentId)
	if self._nextTalentMap then
		return self._nextTalentMap
	end
end

function Rouge2_CareerConfig:getTalentConfigByHoleIndex(index)
	if self._holeIndex2TalentMap then
		if not self._holeIndex2TalentMap then
			logError(string.format("天赋树共鸣器节点配置不存在, 孔位序号: %s", index))
		end

		return self._holeIndex2TalentMap
	end
end

function Rouge2_CareerConfig:getTalentConfigsByStage(stage)
	return self._stage2TalentList and self._stage2TalentList[stage]
end

function Rouge2_CareerConfig:getAllStageTalentConfigs()
	return self._stage2TalentList
end

function Rouge2_CareerConfig:getTalentIcon(talentId, status)
	if self._talentIconUrlMap then
		local status2UrlMap = self._talentIconUrlMap[talentId]
		local iconUrl = status2UrlMap and status2UrlMap[status]

		if string.nilorempty(iconUrl) then
			logError(string.format("天赋点图标配置不存在 talentId = %s, status = %s", talentId, status))
		end

		return iconUrl
	end
end

function Rouge2_CareerConfig:getTalentTransformIdList()
	if not self._talentTransformIdList then
		local talentIdStr = lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.TalentResetIds].value

		self._talentTransformIdList = string.splitToNumber(talentIdStr, "#") or {}
	end

	return self._talentTransformIdList
end

function Rouge2_CareerConfig:getSystemConfig(systemId, noError)
	local systemCo = systemId and lua_rouge2_system.configDict[systemId]

	if not systemCo and not noError then
		logError(string.format("肉鸽体系配置不存在 systemId = %s", systemId))
	end

	return systemCo
end

function Rouge2_CareerConfig:getCareerRecommendTeamList(careerId)
	if self._careerId2RecommendTeamMap then
		return self._careerId2RecommendTeamMap
	end
end

function Rouge2_CareerConfig:isCareerRecommendSystem(careerId, systemId)
	if not careerId or not systemId or systemId == Rouge2_Enum.UnselectTeamSystemId then
		return
	end

	local recommendSystemIdList = self:getCareerRecommendTeamList(careerId) or {}

	for _, recommendSystemId in ipairs(recommendSystemIdList) do
		if systemId == recommendSystemId then
			return true
		end
	end
end

function Rouge2_CareerConfig:getBattleTagConfigBySystemId(systemId)
	if systemId then
		::label_41_0::

		local battleTag = HeroConfig.instance:getBattleTagConfigCO(tostring(systemId))

		if not battleTag then
			logError(string.format("肉鸽战斗标签配置不存在 systemId = %s", systemId))
		end

		return battleTag
	end
end

Rouge2_CareerConfig.instance = Rouge2_CareerConfig.New()

return Rouge2_CareerConfig
