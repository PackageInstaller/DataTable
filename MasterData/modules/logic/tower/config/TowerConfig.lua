-- chunkname: @modules/logic/tower/config/TowerConfig.lua

module("modules.logic.tower.config.TowerConfig", package.seeall)

local TowerConfig = class("TowerConfig", BaseConfig)

function TowerConfig:ctor()
	self.TowerConfig = nil
end

function TowerConfig:reqConfigNames()
	return {
		"tower_const",
		"tower_permanent_time",
		"tower_permanent_episode",
		"tower_mop_up",
		"tower_boss",
		"tower_boss_time",
		"tower_task",
		"tower_limited_time",
		"tower_boss_episode",
		"tower_limited_episode",
		"tower_assist_talent",
		"tower_assist_boss",
		"tower_assist_develop",
		"tower_assist_attribute",
		"tower_talent_plan",
		"tower_hero_trial",
		"tower_boss_teach",
		"tower_score_to_star",
		"tower_new_hero_trial"
	}
end

function TowerConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("on%sLoaded", configName)
	local func = self[funcName]

	if func then
		func(self, configTable)
	end
end

function TowerConfig:ontower_assist_attributeLoaded(configTable)
	self.towerAssistAttrbuteConfig = configTable
end

function TowerConfig:ontower_limited_episodeLoaded(configTable)
	self.towerLimitedEpisodeConfig = configTable

	self:buildTowerLimitedTimeCo()
end

function TowerConfig:buildTowerLimitedTimeCo()
	self.limitEpisodeCoMap = {}

	local allConfigList = self.towerLimitedEpisodeConfig.configList

	for index, config in ipairs(allConfigList) do
		local entranceMap = self.limitEpisodeCoMap[config.season]

		if not entranceMap then
			entranceMap = {}
			self.limitEpisodeCoMap[config.season] = entranceMap
		end

		entranceMap[config.entrance] = entranceMap[config.entrance] or {}

		table.insert(entranceMap[config.entrance], config)
	end
end

function TowerConfig:ontower_limited_timeLoaded(configTable)
	self.towerLimitedTimeConfig = configTable
end

function TowerConfig:ontower_taskLoaded(configTable)
	self.taskConfig = configTable
end

function TowerConfig:ontower_boss_timeLoaded(configTable)
	self.bossTimeConfig = configTable
end

function TowerConfig:ontower_constLoaded(configTable)
	self.towerConstConfig = configTable
end

function TowerConfig:ontower_bossLoaded(configTable)
	self.bossTowerConfig = configTable
end

function TowerConfig:ontower_boss_episodeLoaded(configTable)
	self.bossTowerEpisodeConfig = configTable
end

function TowerConfig:ontower_assist_talentLoaded(configTable)
	self.assistTalentConfig = configTable
end

function TowerConfig:ontower_permanent_timeLoaded(configTable)
	self.towerPermanentTimeConfig = configTable
end

function TowerConfig:ontower_assist_bossLoaded(configTable)
	self.towerAssistBossConfig = configTable
end

function TowerConfig:ontower_assist_developLoaded(configTable)
	self.towerAssistDevelopConfig = configTable
end

function TowerConfig:ontower_permanent_episodeLoaded(configTable)
	self.towerPermanentEpisodeConfig = configTable

	self:buildPermanentEpisodeList()
end

function TowerConfig:buildPermanentEpisodeList()
	self.permanentEpisodeList = {}

	for layerId, config in ipairs(self.towerPermanentEpisodeConfig.configList) do
		self.permanentEpisodeList[config.stageId] = self.permanentEpisodeList[config.stageId] or {}

		table.insert(self.permanentEpisodeList[config.stageId], config)
	end

	for stageId, configList in pairs(self.permanentEpisodeList) do
		table.sort(configList, function(a, b)
			return a.layerId < b.layerId
		end)
	end
end

function TowerConfig:ontower_mop_upLoaded(configTable)
	self.towerMopUpConfig = configTable
end

function TowerConfig:ontower_talent_planLoaded(configTable)
	self.towerTalentPlanConfig = configTable
end

function TowerConfig:ontower_hero_trialLoaded(configTable)
	self.heroTrialConfig = configTable
end

function TowerConfig:ontower_boss_teachLoaded(configTable)
	self.towerBossTeachConfig = configTable

	self:buildBossTeachConfigList()
end

function TowerConfig:ontower_score_to_starLoaded(configTable)
	self.scoreToStarConfig = configTable
end

function TowerConfig:getBossTimeTowerConfig(towerId, round)
	local dict = self.bossTimeConfig.configDict[towerId]

	return dict and dict[round]
end

function TowerConfig:getAssistTalentConfig()
	return self.assistTalentConfig
end

function TowerConfig:getAssistTalentConfigById(bossId, nodeId)
	local dict = self.assistTalentConfig.configDict[bossId]

	return dict and dict[nodeId]
end

function TowerConfig:getBossTowerConfig(towerId)
	return self.bossTowerConfig.configDict[towerId]
end

function TowerConfig:getPermanentEpisodeCo(layerId)
	return self.towerPermanentEpisodeConfig.configDict[layerId]
end

function TowerConfig:getPermanentEpisodeStageCoList(stageId)
	return self.permanentEpisodeList[stageId]
end

function TowerConfig:getPermanentEpisodeLayerCo(stageId, layerIndex)
	local episodeList = self:getPermanentEpisodeStageCoList(stageId)

	if not episodeList or tabletool.len(episodeList) == 0 then
		logError("该阶段数据不存在，请检查: stageId:" .. tostring(stageId))

		return
	end

	return episodeList[layerIndex]
end

function TowerConfig:getTowerPermanentTimeCo(stageId)
	return self.towerPermanentTimeConfig.configDict[stageId]
end

function TowerConfig:getTowerPermanentTimeCoList()
	return self.towerPermanentTimeConfig.configList
end

function TowerConfig:getAssistBossList()
	return self.towerAssistBossConfig.configList
end

function TowerConfig:getAssistBossConfig(bossId)
	return self.towerAssistBossConfig.configDict[bossId]
end

function TowerConfig:getAssistDevelopConfig(bossId, lev)
	local dict = self.towerAssistDevelopConfig.configDict[bossId]

	return dict and dict[lev]
end

function TowerConfig:getAssistBossMaxLev(bossId)
	self._bossLevDict = self._bossLevDict or {}

	if not self._bossLevDict[bossId] then
		local maxLev = 0
		local dict = self.towerAssistDevelopConfig.configDict[bossId]

		for k, v in pairs(dict) do
			if maxLev < k then
				maxLev = k
			end
		end

		self._bossLevDict[bossId] = maxLev
	end

	return self._bossLevDict[bossId]
end

function TowerConfig:getMaxMopUpConfigByLayerId(layerId)
	local coList = self.towerMopUpConfig.configList
	local maxLayerCo

	for index, co in ipairs(coList) do
		if layerId >= co.layerNum then
			maxLayerCo = co
		else
			break
		end
	end

	return maxLayerCo
end

function TowerConfig:getTowerMopUpCo(id)
	return self.towerMopUpConfig.configDict[id]
end

function TowerConfig:getTowerConstConfig(id)
	return self.towerConstConfig.configDict[id] and self.towerConstConfig.configDict[id].value
end

function TowerConfig:getTowerConstLangConfig(id)
	return self.towerConstConfig.configDict[id] and self.towerConstConfig.configDict[id].value2
end

function TowerConfig:getTowerMopUpCoList()
	return self.towerMopUpConfig.configList
end

function TowerConfig:getBossTowerIdByEpisodeId(episodeId)
	if self._episodeId2BossTowerIdDict == nil then
		self._episodeId2BossTowerIdDict = {}

		local coList = self.bossTowerEpisodeConfig.configList

		for index, co in ipairs(coList) do
			self._episodeId2BossTowerIdDict[co.episodeId] = co.towerId
		end
	end

	return self._episodeId2BossTowerIdDict[episodeId]
end

function TowerConfig:getBossTowerEpisodeConfig(towerId, layerId)
	return self.bossTowerEpisodeConfig.configDict[towerId][layerId]
end

function TowerConfig:getBossTowerEpisodeCoList(towerId)
	local coList = self.bossTowerEpisodeConfig.configDict[towerId]

	table.sort(coList, function(a, b)
		return a.layerId < b.layerId
	end)

	return coList
end

function TowerConfig:getTaskListByGroupId(groupId)
	if self._groupId2TaskListDict == nil then
		self._groupId2TaskListDict = {}

		local coList = self.taskConfig.configList

		for index, co in ipairs(coList) do
			self._groupId2TaskListDict[co.taskGroupId] = self._groupId2TaskListDict[co.taskGroupId] or {}

			table.insert(self._groupId2TaskListDict[co.taskGroupId], co.id)
		end
	end

	return self._groupId2TaskListDict[groupId]
end

function TowerConfig:getTowerBossTimeCoByTaskGroupId(taskGroupId)
	local configList = self.bossTimeConfig.configList

	for index, config in ipairs(configList) do
		if config.taskGroupId == taskGroupId then
			return config
		end
	end
end

function TowerConfig:getTowerLimitedCoByTaskGroupId(taskGroupId)
	local configList = self:getAllTowerLimitedTimeCoList()

	for index, config in ipairs(configList) do
		if config.taskGroupId == taskGroupId then
			return config
		end
	end
end

function TowerConfig:getAllTowerLimitedTimeCoList()
	return self.towerLimitedTimeConfig.configList
end

function TowerConfig:getTowerLimitedTimeCo(seasonId)
	return self.towerLimitedTimeConfig.configDict[seasonId]
end

function TowerConfig:getTowerTaskConfig(taskId)
	return self.taskConfig.configDict[taskId]
end

function TowerConfig:getTowerLimitedTimeCoList(season, entrance)
	return self.limitEpisodeCoMap[season] and self.limitEpisodeCoMap[season][entrance]
end

function TowerConfig:getTowerLimitedTimeCoByEpisodeId(season, entrance, episodeId)
	local coList = self:getTowerLimitedTimeCoList(season, entrance)

	for index, co in ipairs(coList) do
		if co.episodeId == episodeId then
			return co
		end
	end
end

function TowerConfig:getTowerLimitedTimeCoByDifficulty(season, entrance, difficulty)
	local coList = self:getTowerLimitedTimeCoList(season, entrance)

	for index, co in ipairs(coList) do
		if co.difficulty == difficulty then
			return co
		end
	end
end

function TowerConfig:getPassiveSKills(bossId)
	if self.bossPassiveSkillDict == nil then
		self.bossPassiveSkillDict = {}
	end

	if not self.bossPassiveSkillDict[bossId] then
		local bossConfig = TowerConfig.instance:getAssistBossConfig(bossId)

		self.bossPassiveSkillDict[bossId] = {}

		local skills1 = string.splitToNumber(bossConfig.passiveSkills, "#")

		table.insert(self.bossPassiveSkillDict[bossId], skills1)
		self:getPassiveSkillActiveLev(bossId, 0)

		local dict = self.bossPassiveSkillLevDict[bossId]
		local skillList = {}

		for k, v in pairs(dict) do
			table.insert(skillList, {
				skillId = k,
				lev = v
			})
		end

		if #skillList > 1 then
			table.sort(skillList, SortUtil.keyLower("lev"))
		end

		for i, v in ipairs(skillList) do
			table.insert(self.bossPassiveSkillDict[bossId], {
				v.skillId
			})
		end
	end

	return self.bossPassiveSkillDict[bossId]
end

function TowerConfig:getPassiveSkillActiveLev(bossId, skillId)
	if self.bossPassiveSkillLevDict == nil then
		self.bossPassiveSkillLevDict = {}
	end

	if not self.bossPassiveSkillLevDict[bossId] then
		self.bossPassiveSkillLevDict[bossId] = {}

		local dict = self.towerAssistDevelopConfig.configDict[bossId]

		if dict then
			local lev = 1
			local config = dict[lev]

			while config do
				if not string.nilorempty(config.passiveSkills) then
					local skills = string.splitToNumber(config.passiveSkills, "#")

					for i, v in ipairs(skills) do
						self.bossPassiveSkillLevDict[bossId][v] = lev
					end
				end

				if not string.nilorempty(config.extraRule) then
					local skills = GameUtil.splitString2(config.extraRule, true)

					for i, v in ipairs(skills) do
						self.bossPassiveSkillLevDict[bossId][v[2]] = lev
					end
				end

				lev = lev + 1
				config = dict[lev]
			end
		end
	end

	return self.bossPassiveSkillLevDict[bossId][skillId] or 0
end

function TowerConfig:isSkillActive(bossId, skillId, bossLev)
	local lev = self:getPassiveSkillActiveLev(bossId, skillId)

	return lev <= bossLev
end

function TowerConfig:getAssistAttribute(bossId, teamLev)
	local dict = self.towerAssistAttrbuteConfig.configDict[bossId]

	return dict and dict[teamLev]
end

function TowerConfig:getBossAddAttr(bossId, bossLev)
	local attrDict = self:getBossAddAttrDict(bossId, bossLev)
	local list = {}

	for k, v in pairs(attrDict) do
		table.insert(list, {
			key = k,
			val = v
		})
	end

	if #list > 0 then
		table.sort(list, SortUtil.keyLower("key"))
	end

	return list
end

function TowerConfig:getBossAddAttrDict(bossId, bossLev)
	local curLev = bossLev or 0
	local attrDict = {}

	for i = 1, curLev do
		local config = TowerConfig.instance:getAssistDevelopConfig(bossId, i)

		if config then
			local temp = GameUtil.splitString2(config.attribute, true)

			if temp then
				for k, v in pairs(temp) do
					attrDict[v[1]] = attrDict[v[1]] == nil and v[2] or attrDict[v[1]] + v[2]
				end
			end
		end
	end

	return attrDict
end

function TowerConfig:getHeroGroupAddAttr(bossId, teamLev, bossLev)
	local attrConfig = TowerConfig.instance:getAssistAttribute(bossId, teamLev)
	local attrDict = self:getBossAddAttrDict(bossId, bossLev)
	local attrList = {}

	for k, v in pairs(TowerEnum.AttrKey) do
		local key = TowerEnum.AttrKey2AttrId[v]

		if not attrDict[key] then
			local add = 0
			local val = attrConfig and attrConfig[v]

			if add > 0 or val ~= nil then
				table.insert(attrList, {
					key = key,
					val = val,
					add = add,
					upAttr = TowerEnum.UpAttrId[v] ~= nil
				})
			end
		end
	end

	if #attrList > 0 then
		table.sort(attrList, SortUtil.keyLower("key"))
	end

	return attrList
end

function TowerConfig:getLimitEpisodeConfig(layerId, difficulty)
	local dict = self.towerLimitedEpisodeConfig.configDict[layerId]

	return dict and dict[difficulty]
end

function TowerConfig:setTalentImg(image, config, setNativeSize)
	local resName

	UISpriteSetMgr.instance:setTowerSprite(image, config.isBigNode == 1 and string.format("towertalent_branchbigskill_%s", config.nodeType) or string.format("towertalent_branchskill_%s", config.nodeType), setNativeSize)
end

function TowerConfig:getTalentPlanConfig(bossId, planId)
	local dict = self.towerTalentPlanConfig.configDict[bossId]

	return dict and dict[planId]
end

function TowerConfig:getAllTalentPlanConfig(bossId)
	local talentPlanDict = self.towerTalentPlanConfig.configDict[bossId]
	local talentPlanList = {}

	if not talentPlanDict then
		logError("bossId: " .. bossId .. "没有推荐天赋方案")

		return talentPlanList
	end

	for index, config in pairs(talentPlanDict) do
		table.insert(talentPlanList, config)
	end

	table.sort(talentPlanList, function(a, b)
		return a.planId < b.planId
	end)

	return talentPlanList
end

function TowerConfig:getTalentPlanNodeIds(bossId, planId, bossLevel)
	local planConfig = self:getTalentPlanConfig(bossId, planId)

	if not planConfig then
		logError("boss:" .. bossId .. " 对应的推荐天赋方案: " .. planId .. "配置不存在")

		return {}
	end

	local talentIds = {}
	local allTalentIds = string.splitToNumber(planConfig.talentIds, "#")
	local totalTalentPoints = self:getAllTalentPoint(bossId, bossLevel)
	local curCostTalentPoint = 0

	for _, talentId in ipairs(allTalentIds) do
		local talentConfig = self:getAssistTalentConfigById(bossId, talentId)

		curCostTalentPoint = curCostTalentPoint + talentConfig.consume

		if curCostTalentPoint <= totalTalentPoints then
			table.insert(talentIds, talentId)
		else
			break
		end
	end

	return talentIds
end

function TowerConfig:getAllTalentPoint(bossId, level)
	local totalTalentPoint = 0
	local dict = self.towerAssistDevelopConfig.configDict[bossId]

	for index, config in pairs(dict) do
		if level >= config.level then
			totalTalentPoint = totalTalentPoint + config.talentPoint
		end
	end

	return totalTalentPoint
end

function TowerConfig:getHeroTrialConfig(seasonId)
	return self.heroTrialConfig.configDict[seasonId]
end

function TowerConfig:getBossTeachConfig(towerId, teachId)
	return self.towerBossTeachConfig.configDict[towerId] and self.towerBossTeachConfig.configDict[towerId][teachId]
end

function TowerConfig:buildBossTeachConfigList()
	self.bossTeachCoList = self.bossTeachCoList or {}

	for index, config in ipairs(self.towerBossTeachConfig.configList) do
		self.bossTeachCoList[config.towerId] = self.bossTeachCoList[config.towerId] or {}

		table.insert(self.bossTeachCoList[config.towerId], config)
	end
end

function TowerConfig:getAllBossTeachConfigList(towerId)
	if self.bossTeachCoList[towerId] then
		return self.bossTeachCoList[towerId]
	else
		logError("该boss塔没有教学配置: " .. towerId)

		return {}
	end
end

function TowerConfig:getScoreToStarConfig(score)
	local curMaxLevel = 0

	for index, config in ipairs(self.scoreToStarConfig.configList) do
		if score >= config.needScore then
			curMaxLevel = config.level
		end
	end

	return curMaxLevel
end

function TowerConfig:checkIsPermanentFinalStageEpisode(episodeId)
	local finalStageEpisodeList = self.permanentEpisodeList[#self.permanentEpisodeList]

	for _, episodeCo in ipairs(finalStageEpisodeList) do
		local episodeList = string.splitToNumber(episodeCo.episodeIds, "|")

		if tabletool.indexOf(episodeList, episodeId) then
			return true, episodeCo
		end
	end

	return false
end

function TowerConfig:ontower_new_hero_trialLoaded(configTable)
	self.newHeroTrialConfig = configTable

	self:buildTowerNewHeroTrialList()
end

function TowerConfig:buildTowerNewHeroTrialList()
	self.newHeroTrialMap = {}
	self.allStageTrialHeroList = {}

	for _, config in ipairs(self.newHeroTrialConfig.configList) do
		self.newHeroTrialMap[config.stageId] = string.splitToNumber(config.heroIds, "|")
	end
end

function TowerConfig:getStageTrialHeroList(stageId)
	return self.newHeroTrialMap[stageId] or {}
end

function TowerConfig:getAllStageTrialHeroList()
	local sameHeroMap = {}

	if #self.allStageTrialHeroList == 0 then
		for _, trialHeroList in pairs(self.newHeroTrialMap) do
			for _, heroId in ipairs(trialHeroList) do
				if not sameHeroMap[heroId] then
					sameHeroMap[heroId] = true

					table.insert(self.allStageTrialHeroList, heroId)
				end
			end
		end
	end

	return self.allStageTrialHeroList
end

TowerConfig.instance = TowerConfig.New()

return TowerConfig
