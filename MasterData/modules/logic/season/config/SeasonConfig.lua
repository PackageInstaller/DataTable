-- chunkname: @modules/logic/season/config/SeasonConfig.lua

module("modules.logic.season.config.SeasonConfig", package.seeall)

local SeasonConfig = class("SeasonConfig", BaseConfig)

function SeasonConfig:ctor()
	return
end

function SeasonConfig:reqConfigNames()
	return {
		"activity104_episode",
		"activity104_const",
		"activity104_retail",
		"activity104_special",
		"activity104_equip",
		"activity104_equip_attr",
		"activity104_equip_tag",
		"activity104_trial",
		"activity104_story",
		"activity104_retail_new"
	}
end

function SeasonConfig:onConfigLoaded(configName, configTable)
	if configName == "activity104_episode" then
		self._episodeConfig = configTable
	elseif configName == "activity104_const" then
		self._constConfig = configTable
	elseif configName == "activity104_retail" then
		self._retailConfig = configTable
	elseif configName == "activity104_special" then
		self._specialConfig = configTable
	elseif configName == "activity104_equip" then
		self._equipConfig = configTable

		self:preprocessEquip()
	elseif configName == "activity104_equip_tag" then
		self._equipTagConfig = configTable
	elseif configName == "activity104_equip_attr" then
		self._equipAttrConfig = configTable
	elseif configName == "activity104_equip_attr" then
		self._equipAttrConfig = configTable
	elseif configName == "activity104_trial" then
		self._trialConfig = configTable
	elseif configName == "activity104_story" then
		self._storyConfig = configTable
	elseif configName == "activity104_retail_new" then
		self._retailNewConfig = configTable
	end
end

function SeasonConfig:getTrialConfig(seasonId, layer)
	return self._trialConfig.configDict[seasonId] and self._trialConfig.configDict[seasonId][layer]
end

function SeasonConfig:getTrialCount(seasonId)
	local dict = self._trialConfig.configDict[seasonId]

	return tabletool.len(dict)
end

function SeasonConfig:preprocessEquip()
	self._equipIsOptionalDict = {}
	self._equipIsOptionalList = {}

	for _, cfg in pairs(self._equipConfig.configList) do
		if cfg.isOptional == 1 then
			self._equipIsOptionalDict[cfg.equipId] = true

			table.insert(self._equipIsOptionalList, cfg)
		end
	end
end

function SeasonConfig:getSeasonEpisodeCos(seasonId)
	return self._episodeConfig.configDict[seasonId]
end

function SeasonConfig:getSeasonEpisodeCo(seasonId, layer)
	return self._episodeConfig.configDict[seasonId][layer]
end

function SeasonConfig:getSeasonConstCo(seasonId, constId)
	local dict = self._constConfig.configDict[seasonId]
	local co = dict and dict[constId]

	if not co then
		logError(string.format("const no exist seasonid:%s constid:%s", seasonId, constId))
	end

	return co
end

function SeasonConfig:getSeasonRetailCos(seasonId)
	return self._retailConfig.configDict[seasonId]
end

function SeasonConfig:getSeasonRetailCo(seasonId, stage)
	return self._retailConfig.configDict[seasonId][stage]
end

function SeasonConfig:getSeasonSpecialCos(seasonId)
	return self._specialConfig.configDict[seasonId]
end

function SeasonConfig:getSeasonSpecialCo(seasonId, layer)
	return self._specialConfig.configDict[seasonId][layer]
end

function SeasonConfig:getSeasonEquipCos()
	return self._equipConfig.configDict
end

function SeasonConfig:getSeasonEquipCo(equipId)
	return self._equipConfig.configDict[equipId]
end

function SeasonConfig:getSeasonOptionalEquipCos()
	return self._equipIsOptionalList
end

function SeasonConfig:getSeasonTagDict(actId)
	return self._equipTagConfig.configDict[actId]
end

function SeasonConfig:getSeasonTagDesc(actId, id)
	local dcit = self:getSeasonTagDict(actId)
	local data = dcit and dcit[id]

	if not data then
		logError(string.format("not tag config seasonId:%s tagId:%s", actId, id))
	end

	return data
end

function SeasonConfig:getEquipIsOptional(equipId)
	return self._equipIsOptionalDict[equipId]
end

function SeasonConfig:getEquipCoByCondition(filterFunc)
	local list = {}

	for _, cfg in ipairs(self._equipConfig.configList) do
		if filterFunc(cfg) then
			table.insert(list, cfg)
		end
	end

	return list
end

function SeasonConfig:getSeasonEquipAttrCo(attrId)
	return self._equipAttrConfig.configDict[attrId]
end

function SeasonConfig:getConfigByEpisodeId(episode_id)
	self:_initEpisodeId2Config()

	return self._episodeId2Config and self._episodeId2Config[episode_id]
end

function SeasonConfig:_initEpisodeId2Config()
	if self._episodeId2Config then
		return
	end

	self._episodeId2Config = {}

	for k, v in pairs(self._episodeConfig.configDict) do
		self._episodeId2Config[v.episodeId] = v
	end
end

function SeasonConfig:getStoryIds(actId)
	local co = self:getSeasonConstCo(actId, Activity104Enum.ConstEnum.SeasonOpenStorys)

	return {
		co.value1
	}
end

function SeasonConfig:getRetailTicket(actId)
	local co = self:getSeasonConstCo(actId, Activity104Enum.ConstEnum.RetailTicket)

	return co.value1
end

function SeasonConfig:getRuleTips(actId)
	local co = self:getSeasonConstCo(actId, Activity104Enum.ConstEnum.RuleTips)

	return (string.splitToNumber(co.value2, "#"))
end

function SeasonConfig:isExistInRuleTips(actId, ruleId)
	self._ruleDict = self._ruleDict or {}

	if not self._ruleDict[actId] then
		self._ruleDict[actId] = {}

		local list = self:getRuleTips(actId)

		if list then
			for k, v in pairs(list) do
				self._ruleDict[actId][v] = true
			end
		end
	end

	return self._ruleDict[actId][ruleId] ~= nil
end

function SeasonConfig:filterRule(ruleList)
	local list = {}

	if ruleList then
		local actId = Activity104Model.instance:getCurSeasonId()

		for k, v in pairs(ruleList) do
			if not self:isExistInRuleTips(actId, v[2]) then
				table.insert(list, v)
			end
		end
	end

	return list
end

function SeasonConfig:getAllStoryCo(actId)
	return self._storyConfig.configDict[actId]
end

function SeasonConfig:getStoryConfig(actId, storyId)
	return self._storyConfig.configDict[actId][storyId]
end

function SeasonConfig:getSeasonConstStr(actId, constId)
	local co = self:getSeasonConstCo(actId, constId)

	if not co then
		return
	end

	return co.value2
end

function SeasonConfig:getSeasonConstLangStr(actId, constId)
	local co = self:getSeasonConstCo(actId, constId)

	if not co then
		return
	end

	return co.value3
end

function SeasonConfig:getSeasonRetailEpisodeCo(seasonId, episodeId)
	local co = self._retailNewConfig.configDict[seasonId][episodeId]

	if not co then
		logError(string.format("not retail config seasonId:%s episodeId:%s", seasonId, episodeId))
	end

	return co
end

function SeasonConfig:getSeasonRetailEpisodes(seasonId)
	local dict = self._retailNewConfig.configDict[seasonId]

	if not dict then
		logError(string.format("not retail episodelist seasonId:%s", seasonId))
	end

	return dict
end

SeasonConfig.instance = SeasonConfig.New()

return SeasonConfig
