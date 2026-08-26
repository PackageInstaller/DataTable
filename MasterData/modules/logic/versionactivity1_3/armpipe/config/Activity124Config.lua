-- chunkname: @modules/logic/versionactivity1_3/armpipe/config/Activity124Config.lua

module("modules.logic.versionactivity1_3.armpipe.config.Activity124Config", package.seeall)

local Activity124Config = class("Activity124Config", BaseConfig)

function Activity124Config:ctor()
	self._act124Map = nil
	self._act124Episode = nil
	self._episodeListDict = {}
	self._chapterIdListDict = {}
end

function Activity124Config:reqConfigNames()
	return {
		"activity124_map",
		"activity124_episode"
	}
end

function Activity124Config:onConfigLoaded(configName, configTable)
	if configName == "activity124_map" then
		self._act124Map = configTable
	elseif configName == "activity124_episode" then
		self._act124Episode = configTable
	end
end

function Activity124Config:getMapCo(actId, id)
	if self._act124Map.configDict[actId] then
		return self._act124Map.configDict[actId][id]
	end

	return nil
end

function Activity124Config:getEpisodeCo(actId, id)
	if self._act124Episode.configDict[actId] then
		return self._act124Episode.configDict[actId][id]
	end

	return nil
end

function Activity124Config:getEpisodeList(actId)
	if self._episodeListDict[actId] then
		return self._episodeListDict[actId]
	end

	local episodeList = {}

	self._episodeListDict[actId] = episodeList

	if self._act124Episode and self._act124Episode.configDict[actId] then
		for k, v in pairs(self._act124Episode.configDict[actId]) do
			table.insert(episodeList, v)
		end

		table.sort(episodeList, Activity124Config.sortEpisode)
	end

	return episodeList
end

function Activity124Config.sortEpisode(item1, item2)
	if item1.episodeId ~= item2.episodeId then
		return item1.episodeId < item2.episodeId
	end
end

Activity124Config.instance = Activity124Config.New()

return Activity124Config
