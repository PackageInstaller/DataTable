-- chunkname: @modules/logic/versionactivity2_6/xugouji/config/Activity188Config.lua

module("modules.logic.versionactivity2_6.xugouji.config.Activity188Config", package.seeall)

local Activity188Config = class("Activity188Config", BaseConfig)

function Activity188Config:onInit()
	self._episodeCfg = nil
	self._gameCfg = nil
	self._aiCfg = nil
	self._abilityCfg = nil
	self._skillCfg = nil
	self._taskCfg = nil
	self._buffCfg = nil
	self._cardCfg = nil
	self._constCfg = nil
	self._episodeDict = {}
end

function Activity188Config:reqConfigNames()
	return {
		"activity188_episode",
		"activity188_game",
		"activity188_ai",
		"activity188_ability",
		"activity188_skill",
		"activity188_buff",
		"activity188_task",
		"activity188_card",
		"activity188_const"
	}
end

function Activity188Config:onConfigLoaded(configName, configTable)
	if configName == "activity188_episode" then
		self._episodeCfg = configTable
		self._episodeDict = {}

		for _, v in ipairs(self._episodeCfg.configList) do
			self._episodeDict[v.activityId] = self._episodeDict[v.activityId] or {}

			table.insert(self._episodeDict[v.activityId], v)
		end
	elseif configName == "activity188_game" then
		self._gameCfg = configTable
	elseif configName == "activity188_ai" then
		self._aiCfg = configTable
	elseif configName == "activity188_ability" then
		self._abilityCfg = configTable
	elseif configName == "activity188_skill" then
		self._skillCfg = configTable
	elseif configName == "activity188_task" then
		self._taskCfg = configTable
	elseif configName == "activity188_buff" then
		self._buffCfg = configTable
	elseif configName == "activity188_card" then
		self._cardCfg = configTable
	elseif configName == "activity188_const" then
		self._constCfg = configTable
	end
end

function Activity188Config:getEpisodeCfgList(activityId)
	return self._episodeDict[activityId] or {}
end

function Activity188Config:getEpisodeCfg(activityId, episodeId)
	local activityEpisodeList = self._episodeDict[activityId]

	if not activityEpisodeList then
		return nil
	end

	for _, episoCfg in ipairs(activityEpisodeList) do
		if episoCfg.episodeId == episodeId then
			return episoCfg
		end
	end
end

function Activity188Config:getEpisodeCfgByEpisodeId(episodeId)
	for activityId, activityEpisodeList in pairs(self._episodeDict) do
		for _, episoCfg in ipairs(activityEpisodeList) do
			if episoCfg.episodeId == episodeId then
				return episoCfg
			end
		end
	end
end

function Activity188Config:getEpisodeCfgByPreEpisodeId(episodeId)
	for activityId, activityEpisodeList in pairs(self._episodeDict) do
		for _, episoCfg in ipairs(activityEpisodeList) do
			if episoCfg.preEpisodeId == episodeId then
				return episoCfg
			end
		end
	end
end

function Activity188Config:getEventCfg(activityId, eventId)
	local actEvents = self._eventConfig.configDict[activityId]

	return actEvents and actEvents[eventId]
end

function Activity188Config:getCardCfg(activityId, cardId)
	local activityCards = self._cardCfg.configDict[activityId]

	return activityCards[cardId]
end

function Activity188Config:getCardSkillCfg(activityId, skillId)
	local activitySkills = self._skillCfg.configDict[activityId]

	return activitySkills[skillId]
end

function Activity188Config:getGameCfg(activityId, gameId)
	local gameCfgs = self._gameCfg.configDict[activityId]

	return gameCfgs and gameCfgs[gameId]
end

function Activity188Config:getAbilityCfg(activityId, id)
	local activityCards = self._abilityCfg.configDict[activityId]

	return activityCards[id]
end

function Activity188Config:getGameItemListCfg(activityId, _type)
	local result = {}
	local activityItemList = self._itemConfig.configDict[activityId]

	for _, itemCfg in pairs(activityItemList) do
		if _type == nil or itemCfg.compostType == _type then
			result[#result + 1] = itemCfg
		end
	end

	return result
end

function Activity188Config:getTaskList(activityId)
	if self._task_list then
		return self._task_list
	end

	self._task_list = {}

	for k, v in pairs(self._taskCfg.configDict) do
		if activityId == v.activityId then
			self._task_list[#self._task_list + 1] = v
		end
	end

	return self._task_list
end

function Activity188Config:getConstCfg(activityId, subId)
	local activityConstCfgList = self._constCfg.configDict[activityId]

	if not activityConstCfgList then
		return
	end

	for k, v in pairs(activityConstCfgList) do
		if subId == v.id then
			return v
		end
	end
end

function Activity188Config:getConstValueCfg(activityId, value1)
	local activityConstCfgList = self._constCfg.configDict[activityId]

	if not activityConstCfgList then
		return
	end

	for k, v in ipairs(activityConstCfgList) do
		if value1 == v.value1 then
			return v
		end
	end
end

function Activity188Config:getBuffCfg(activityId, buffId)
	local activityBuffCfgs = self._buffCfg.configDict[activityId]

	return activityBuffCfgs and activityBuffCfgs[buffId]
end

Activity188Config.instance = Activity188Config.New()

return Activity188Config
