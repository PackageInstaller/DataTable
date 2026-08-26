-- chunkname: @modules/logic/tower/config/TowerDeepConfig.lua

module("modules.logic.tower.config.TowerDeepConfig", package.seeall)

local TowerDeepConfig = class("TowerDeepConfig", BaseConfig)

function TowerDeepConfig:ctor()
	self.TowerDeepConfig = nil
end

function TowerDeepConfig:reqConfigNames()
	return {
		"tower_deep_const",
		"tower_deep_task",
		"tower_deep_monster",
		"tower_deep_new_hero_trial"
	}
end

function TowerDeepConfig:onConfigLoaded(configName, configTable)
	if configName == "tower_deep_const" then
		self._constConfig = configTable
	elseif configName == "tower_deep_task" then
		self._taskConfig = configTable
	elseif configName == "tower_deep_monster" then
		self._deepMonsterConfig = configTable
	elseif configName == "tower_deep_new_hero_trial" then
		self._deepHeroTrialConfig = configTable

		self:buildDeepHeroTrialList()
	end
end

function TowerDeepConfig:getConstConfigValue(id, isString)
	local config = self._constConfig.configDict[id]

	if config then
		return (isString or nil) and (config.value or tonumber(config.value))
	end
end

function TowerDeepConfig:getConstConfigLangValue(id)
	local config = self._constConfig.configDict[id]

	if config then
		return config.value2
	end
end

function TowerDeepConfig:getTaskConfig(id)
	return self._taskConfig.configDict[id]
end

function TowerDeepConfig:getTaskConfigList()
	return self._taskConfig.configList
end

function TowerDeepConfig:getDeepMonsterId(deepHigh)
	for index, config in ipairs(self._deepMonsterConfig.configList) do
		if deepHigh >= config.startHighDeep and deepHigh <= config.endHighDeep then
			return config.bossId
		end
	end

	return self._deepMonsterConfig.configList[1].bossId
end

function TowerDeepConfig:buildDeepHeroTrialList()
	self.deepHeroTrialMap = {}
	self.allDeepTrialHeroList = {}

	for index, config in ipairs(self._deepHeroTrialConfig.configList) do
		self.deepHeroTrialMap[config.id] = string.splitToNumber(config.heroIds, "|")
	end
end

function TowerDeepConfig:getHeroTrialList(episodeId)
	return self.deepHeroTrialMap[episodeId]
end

function TowerDeepConfig:getAllHeroTrialList()
	local sameHeroMap = {}

	if #self.allDeepTrialHeroList == 0 then
		for episodeId, trialHeroList in pairs(self.deepHeroTrialMap) do
			for _, heroId in ipairs(trialHeroList) do
				if not sameHeroMap[heroId] then
					sameHeroMap[heroId] = true

					table.insert(self.allDeepTrialHeroList, heroId)
				end
			end
		end
	end

	return self.allDeepTrialHeroList
end

TowerDeepConfig.instance = TowerDeepConfig.New()

return TowerDeepConfig
