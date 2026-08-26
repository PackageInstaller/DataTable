-- chunkname: @modules/logic/meilanni/config/MeilanniConfig.lua

module("modules.logic.meilanni.config.MeilanniConfig", package.seeall)

local MeilanniConfig = class("MeilanniConfig", BaseConfig)

function MeilanniConfig:reqConfigNames()
	return {
		"activity108_map",
		"activity108_episode",
		"activity108_event",
		"activity108_dialog",
		"activity108_grade",
		"activity108_rule",
		"activity108_story",
		"activity108_score"
	}
end

function MeilanniConfig:onInit()
	return
end

function MeilanniConfig:onConfigLoaded(configName, configTable)
	if configName == "activity108_dialog" then
		self:_initDialog()
	elseif configName == "activity108_episode" then
		self._episodeConfig = configTable

		self:_initEpisode()
	elseif configName == "activity108_event" then
		self:_initEvent()
	elseif configName == "activity108_story" then
		self:_initStory()
	elseif configName == "activity108_grade" then
		self:_initGrade()
	elseif configName == "activity108_score" then
		-- block empty
	end
end

function MeilanniConfig:_initEpisode()
	self._mapLastEpisode = {}

	for i, v in ipairs(lua_activity108_episode.configList) do
		if not self._mapLastEpisode[v.mapId] then
			local lastConfig = v

			if v.id > self._mapLastEpisode[v.mapId].id then
				lastConfig = v
			end

			self._mapLastEpisode[self._mapLastEpisode[v.mapId].mapId] = self._mapLastEpisode[v.mapId]
		end
	end
end

function MeilanniConfig:getLastEpisode(mapId)
	return self._mapLastEpisode[mapId]
end

function MeilanniConfig:getLastEvent(mapId)
	return self._mapLastEvent[mapId]
end

function MeilanniConfig:_initEvent()
	local lastEpisodeId = {}

	for i, v in ipairs(lua_activity108_map.configList) do
		local lastEpisodeConfig = self:getLastEpisode(v.id)

		if lastEpisodeConfig then
			lastEpisodeId[lastEpisodeConfig.id] = lastEpisodeConfig
		end
	end

	self._mapLastEvent = {}

	for i, v in ipairs(lua_activity108_event.configList) do
		local lastEpisodeConfig = lastEpisodeId[v.episodeId]

		if lastEpisodeConfig then
			self._mapLastEvent[lastEpisodeConfig.mapId] = v
		end
	end
end

function MeilanniConfig:_initStory()
	self._storyList = {}

	for i, v in ipairs(lua_activity108_story.configList) do
		local paramList = string.splitToNumber(v.params, "#")
		local type = paramList[1]
		local param = paramList[2]
		local param2 = paramList[3]

		if not self._storyList[type] then
			self._storyList[type] = self._storyList[type]

			table.insert(self._storyList[type], {
				v,
				param,
				param2
			})
		end
	end
end

function MeilanniConfig:getStoryList(type)
	return self._storyList[type]
end

function MeilanniConfig:_initGrade()
	self._gradleList = {}

	for i, v in ipairs(lua_activity108_grade.configList) do
		if not self._gradleList[v.mapId] then
			table.insert(self._gradleList[v.mapId], 1, v)

			self._gradleList[v.mapId] = self._gradleList[v.mapId]
		end
	end
end

function MeilanniConfig:getScoreIndex(score)
	score = math.min(score, 100)

	local len = #lua_activity108_score.configList

	for i, v in ipairs(lua_activity108_score.configList) do
		if score >= v.minScore and score <= v.maxScore then
			return len - i + 1
		end
	end

	return len
end

function MeilanniConfig:getGradleIndex(mapId, score)
	local list = self._gradleList[mapId]

	for i, v in ipairs(list) do
		if score >= v.score then
			return i
		end
	end

	return #list
end

function MeilanniConfig:getGradleList(mapId)
	return self._gradleList[mapId]
end

function MeilanniConfig:_initDialog()
	self._dialogList = {}

	local sectionId
	local defaultId = "0"

	for i, v in ipairs(lua_activity108_dialog.configList) do
		local group = self._dialogList[v.id]

		if not group then
			group = {}
			sectionId = defaultId
			self._dialogList[v.id] = group
		end

		if v.type == "selector" then
			sectionId = v.param
			group[sectionId] = group[v.param] or {}
			group[sectionId].type = v.type
			group[sectionId].option_param = v.option_param
			group[sectionId].result = v.result
		elseif v.type == "selectorend" then
			sectionId = defaultId
		elseif v.type == "random" then
			local sectionId = v.param

			group[sectionId] = group[sectionId] or {}
			group[sectionId].type = v.type
			group[sectionId].option_param = v.option_param

			table.insert(group[sectionId], v)
		elseif v.stepId > 0 then
			group[sectionId] = group[sectionId] or {}

			table.insert(group[sectionId], v)
		end
	end
end

function MeilanniConfig:getDialog(groupId, sectionId)
	local group = self._dialogList[groupId]

	return group and group[sectionId]
end

function MeilanniConfig:getElementConfig(id)
	local config = lua_activity108_event.configDict[id]

	if not config then
		logError(string.format("getElementConfig no config id:%s", id))
	end

	return config
end

function MeilanniConfig:getEpisodeConfig(episodeId)
	return self._episodeConfig.configDict[episodeId]
end

function MeilanniConfig:getEpisodeConfigListByMapId(mapId)
	local episodeConfigList = {}

	for i, episodeConfig in ipairs(self._episodeConfig.configList) do
		if episodeConfig.mapId == mapId then
			table.insert(episodeConfigList, episodeConfig)
		end
	end

	return episodeConfigList
end

MeilanniConfig.instance = MeilanniConfig.New()

return MeilanniConfig
