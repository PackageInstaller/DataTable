-- chunkname: @modules/logic/towercompose/config/TowerComposeConfig.lua

module("modules.logic.towercompose.config.TowerComposeConfig", package.seeall)

local TowerComposeConfig = class("TowerComposeConfig", BaseConfig)

function TowerComposeConfig:ctor()
	self.TowerComposeConfig = nil
end

function TowerComposeConfig:reqConfigNames()
	return {
		"tower_compose_const",
		"tower_compose_theme",
		"tower_compose_episode",
		"tower_compose_mod",
		"tower_compose_research",
		"tower_compose_support",
		"tower_compose_extra",
		"tower_compose_task",
		"tower_compose_boss_lv",
		"tower_compose_point_level",
		"tower_compose_point_round"
	}
end

function TowerComposeConfig:onConfigLoaded(configName, configTable)
	if configName == "tower_compose_const" then
		self._constConfig = configTable
	elseif configName == "tower_compose_theme" then
		self._themeConfig = configTable

		self:buildModNumData()
		self:buildThemeTrialData()
	elseif configName == "tower_compose_episode" then
		self._episodeConfig = configTable

		self:buildEpisodeData()
	elseif configName == "tower_compose_mod" then
		self._modConfig = configTable

		self:buildModData()
	elseif configName == "tower_compose_research" then
		self._researchConfig = configTable

		self:buildResearchData()
	elseif configName == "tower_compose_support" then
		self._supportConfig = configTable

		self:buildSupportData()
		self:buildHeroSupportData()
	elseif configName == "tower_compose_extra" then
		self._extraConfig = configTable

		self:buildExtraData()
	elseif configName == "tower_compose_task" then
		self._taskConfig = configTable
	elseif configName == "tower_compose_boss_lv" then
		self._bossLvConfig = configTable

		self:buildBossLvData()
	elseif configName == "tower_compose_point_level" then
		self._pointLevelConfig = configTable
	elseif configName == "tower_compose_point_round" then
		self._pointRoundConfig = configTable
	end
end

function TowerComposeConfig:buildModNumData()
	self.modNumMap = {}

	for _, themeConfig in ipairs(self._themeConfig.configList) do
		local modNumList = string.split(themeConfig.modNum, "|")

		self.modNumMap[themeConfig.id] = self.modNumMap[themeConfig.id] or {}

		for _, modNumStr in ipairs(modNumList) do
			local modNumData = string.splitToNumber(modNumStr, "#")
			local modType = modNumData[1]

			self.modNumMap[themeConfig.id][modType] = modNumData[2]
		end
	end
end

function TowerComposeConfig:getModTypeNum(themeId, modType)
	return self.modNumMap[themeId] and self.modNumMap[themeId][modType]
end

function TowerComposeConfig:buildThemeTrialData()
	self.themeHeroTrialMap = {}
	self.allThemeTrialHeroList = {}

	for _, themeConfig in ipairs(self._themeConfig.configList) do
		self.themeHeroTrialMap[themeConfig.id] = string.splitToNumber(themeConfig.heroIds, "|")
	end
end

function TowerComposeConfig:getAllThemeTrialHeroList()
	local sameHeroMap = {}

	if #self.allThemeTrialHeroList == 0 then
		for themeId, trialHeroList in pairs(self.themeHeroTrialMap) do
			for _, heroId in ipairs(trialHeroList) do
				if not sameHeroMap[heroId] then
					sameHeroMap[heroId] = true

					table.insert(self.allThemeTrialHeroList, heroId)
				end
			end
		end
	end

	return self.allThemeTrialHeroList
end

function TowerComposeConfig:getThemeTrialHeroList(themeId)
	return self.themeHeroTrialMap[themeId] or {}
end

function TowerComposeConfig:getThemeConfig(themeId)
	return self._themeConfig.configDict[themeId]
end

function TowerComposeConfig:getAllThemeConfig()
	return self._themeConfig.configList
end

function TowerComposeConfig:isThemeConfigCanOpen(themeId)
	local themeConfig = self:getThemeConfig(themeId)

	return themeConfig and themeConfig.isOnline == 1
end

function TowerComposeConfig:buildEpisodeData()
	self.themeAllEpisodeCoList = {}
	self.normalEpisodeCoList = {}

	for _, episodeCo in ipairs(self._episodeConfig.configList) do
		if not self.themeAllEpisodeCoList[episodeCo.themeId] then
			self.themeAllEpisodeCoList[episodeCo.themeId] = {}
			self.normalEpisodeCoList[episodeCo.themeId] = {}
		end

		if episodeCo.plane == 0 then
			table.insert(self.normalEpisodeCoList[episodeCo.themeId], episodeCo)
		end

		table.insert(self.themeAllEpisodeCoList[episodeCo.themeId], episodeCo)
	end
end

function TowerComposeConfig:getThemeAllEpisodeConfig(themeId)
	local episodeCoList = self.themeAllEpisodeCoList[themeId]

	if not episodeCoList or not next(episodeCoList) then
		logError(themeId .. " 这个主题Id的配置不存在，请检查")
	end

	return episodeCoList
end

function TowerComposeConfig:getEpisodeConfig(themeId, layerId)
	return self._episodeConfig.configDict[themeId] and self._episodeConfig.configDict[themeId][layerId]
end

function TowerComposeConfig:getThemeAllPlaneLayerIdList(themeId)
	local coList = self:getThemeAllEpisodeConfig(themeId)
	local planeIdList = {}

	for _, co in ipairs(coList) do
		if co.plane > 0 then
			table.insert(planeIdList, co.layerId)
		end
	end

	return planeIdList
end

function TowerComposeConfig:getNormalEpisodeIndex(themeId, layerId)
	local episodeCoList = self.normalEpisodeCoList[themeId]
	local curLayerIndex = 1

	if not episodeCoList or not next(episodeCoList) then
		logError(themeId .. " 这个主题Id的配置不存在，请检查")

		return curLayerIndex
	end

	for index, co in ipairs(episodeCoList) do
		if layerId >= co.layerId then
			curLayerIndex = index
		end
	end

	return curLayerIndex
end

function TowerComposeConfig:buildModData()
	self.typeModCoMap = {}

	for _, config in ipairs(self._modConfig.configList) do
		self.typeModCoMap[config.themeId] = self.typeModCoMap[config.themeId] or {}

		local typeCoList = self.typeModCoMap[config.themeId][config.type]

		if not typeCoList then
			typeCoList = {}
			self.typeModCoMap[config.themeId][config.type] = typeCoList
		end

		table.insert(typeCoList, config)
	end
end

function TowerComposeConfig:getThemeModTypeCoList(themeId, type)
	return self.typeModCoMap[themeId] and self.typeModCoMap[themeId][type]
end

function TowerComposeConfig:getComposeModConfig(modId)
	return self._modConfig.configDict[modId]
end

function TowerComposeConfig:getComposeAllModBySlot(themeId, type, slotId)
	local modConfigList = {}
	local typeCoList = self:getThemeModTypeCoList(themeId, type)

	if not typeCoList or not next(typeCoList) then
		logError("主题" .. themeId .. "插件类型" .. type .. "配置不存在，请检查")

		return modConfigList
	end

	for _, modConfig in ipairs(typeCoList) do
		if modConfig.slot == slotId or modConfig.slot == 0 then
			table.insert(modConfigList, modConfig)
		end
	end

	return modConfigList
end

function TowerComposeConfig:buildResearchData()
	self.themeResearchList = {}

	for _, config in ipairs(self._researchConfig.configList) do
		self.themeResearchList[config.themeId] = self.themeResearchList[config.themeId] or {}

		table.insert(self.themeResearchList[config.themeId], config)
	end

	for _, configList in pairs(self.themeResearchList) do
		table.sort(configList, function(a, b)
			return a.req < b.req
		end)
	end
end

function TowerComposeConfig:getAllResearchCoList(themeId)
	return self.themeResearchList[themeId] or {}
end

function TowerComposeConfig:getResearchCo(researchId)
	return self._researchConfig.configDict[researchId]
end

function TowerComposeConfig:getMaxResearchNum(themeId)
	local configList = self:getAllResearchCoList(themeId)
	local maxConfig = configList[#configList]

	return maxConfig.req
end

function TowerComposeConfig:buildSupportData()
	self.themeSupportCoList = {}

	for _, config in ipairs(self._supportConfig.configList) do
		self.themeSupportCoList[config.themeId] = self.themeSupportCoList[config.themeId] or {}

		table.insert(self.themeSupportCoList[config.themeId], config)
	end
end

function TowerComposeConfig:buildHeroSupportData()
	self.themeHeroSupportCoMap = {}

	for _, config in ipairs(self._supportConfig.configList) do
		self.themeHeroSupportCoMap[config.themeId] = self.themeHeroSupportCoMap[config.themeId] or {}
		self.themeHeroSupportCoMap[config.themeId][config.heroId] = self.themeHeroSupportCoMap[config.themeId][config.heroId] or {}
		self.themeHeroSupportCoMap[config.themeId][config.heroId][config.lv] = config
	end
end

function TowerComposeConfig:getAllSupportCoList(themeId)
	return self.themeSupportCoList[themeId] or {}
end

function TowerComposeConfig:getSupportCo(id)
	return self._supportConfig.configDict[id]
end

function TowerComposeConfig:getThemeCurLvHeroIdSupportCo(themeId, heroId, lv)
	return self.themeHeroSupportCoMap[themeId] and self.themeHeroSupportCoMap[themeId][heroId] and self.themeHeroSupportCoMap[themeId][heroId][lv]
end

function TowerComposeConfig:buildExtraData()
	self.themeExtraCoList = {}

	for _, config in ipairs(self._extraConfig.configList) do
		self.themeExtraCoList[config.themeId] = self.themeExtraCoList[config.themeId] or {}

		table.insert(self.themeExtraCoList[config.themeId], config)
	end
end

function TowerComposeConfig:getAllExtraCoList(themeId)
	return self.themeExtraCoList[themeId] or {}
end

function TowerComposeConfig:getExtraCo(id)
	return self._extraConfig.configDict[id]
end

function TowerComposeConfig:checkIsExtraHero(themeId, heroId)
	local allExtraCoList = self:getAllExtraCoList(themeId)

	for _, co in ipairs(allExtraCoList) do
		if co.id == heroId then
			return true, co
		end
	end

	return false
end

function TowerComposeConfig:getConstValue(constId, isNum, isLang)
	local config = self._constConfig.configDict[constId]

	if isLang then
		if not config.value2 then
			local value = config.value

			return isNum and not isLang and tonumber(value) or value
		end
	end
end

function TowerComposeConfig:getTowerComposeTaskConfig(taskId)
	return self._taskConfig.configDict[taskId]
end

function TowerComposeConfig:buildBossLvData()
	self.bossLvCoList = {}

	for _, config in ipairs(self._bossLvConfig.configList) do
		self.bossLvCoList[config.episodeId] = self.bossLvCoList[config.episodeId] or {}

		table.insert(self.bossLvCoList[config.episodeId], config)
	end

	for episodeId, coList in pairs(self.bossLvCoList) do
		table.sort(coList, function(a, b)
			return a.level < b.level
		end)
	end
end

function TowerComposeConfig:getTowerComposeBossLvConfig(episodeId, level)
	return self._bossLvConfig.configDict[episodeId] and self._bossLvConfig.configDict[episodeId][level]
end

function TowerComposeConfig:getBossLevelCo(episodeId, level)
	local coList = self.bossLvCoList[episodeId]
	local curBossLvCo

	for index, bossLvCo in ipairs(coList) do
		if level >= bossLvCo.level then
			curBossLvCo = bossLvCo
		else
			break
		end
	end

	return curBossLvCo
end

function TowerComposeConfig:getPointLevelConfig(level)
	self.maxLevel = self._pointLevelConfig.configList[#self._pointLevelConfig.configList].level

	local curLevel = Mathf.Min(level, self.maxLevel)

	return self._pointLevelConfig.configDict[curLevel]
end

function TowerComposeConfig:getModSlotNumMap(themeId)
	if not self.modSlotNumMap or not next(self.modSlotNumMap) then
		local themeConfig = self:getThemeConfig(themeId)
		local modSlotNumDataList = GameUtil.splitString2(themeConfig.modNum, true)

		self.modSlotNumMap = {}

		for _, modSlotNumData in ipairs(modSlotNumDataList) do
			self.modSlotNumMap[modSlotNumData[1]] = modSlotNumData[2]
		end
	end

	return self.modSlotNumMap
end

function TowerComposeConfig:getPointRoundCoList()
	return self._pointRoundConfig.configList
end

function TowerComposeConfig:getThemeInitEnv(themeId)
	local themeConfig = self:getThemeConfig(themeId)

	return themeConfig.initEnv
end

TowerComposeConfig.instance = TowerComposeConfig.New()

return TowerComposeConfig
