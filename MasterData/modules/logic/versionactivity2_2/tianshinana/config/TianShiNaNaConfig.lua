-- chunkname: @modules/logic/versionactivity2_2/tianshinana/config/TianShiNaNaConfig.lua

module("modules.logic.versionactivity2_2.tianshinana.config.TianShiNaNaConfig", package.seeall)

local TianShiNaNaConfig = class("TianShiNaNaConfig", BaseConfig)

function TianShiNaNaConfig:onInit()
	self._mapCos = {}
	self._taskDict = {}
end

function TianShiNaNaConfig:reqConfigNames()
	return {
		"activity167_episode",
		"activity167_task",
		"activity167_bubble"
	}
end

function TianShiNaNaConfig:getMapCo(mapId)
	if not self._mapCos[mapId] then
		local co = TianShiNaNaMapCo.New()
		local rawCo = addGlobalModule("modules.configs.tianshinana.lua_tianshinana_map_" .. tostring(mapId), "lua_tianshinana_map_" .. tostring(mapId))

		if not rawCo then
			logError("天使娜娜地图配置不存在" .. mapId)

			return
		end

		co:init(rawCo)

		self._mapCos[mapId] = co
	end

	return self._mapCos[mapId]
end

function TianShiNaNaConfig:getEpisodeByMapId(mapId)
	if not self._mapIdToEpisodeCo then
		self._mapIdToEpisodeCo = {}

		for _, v in ipairs(lua_activity167_episode.configList) do
			self._mapIdToEpisodeCo[v.mapId] = v
		end
	end

	return self._mapIdToEpisodeCo[mapId]
end

function TianShiNaNaConfig:getEpisodeCoList(activityId)
	if not self._episodeDict then
		self._episodeDict = {}

		for _, v in ipairs(lua_activity167_episode.configList) do
			self._episodeDict[v.activityId] = self._episodeDict[v.activityId] or {}

			table.insert(self._episodeDict[v.activityId], v)
		end
	end

	return self._episodeDict[activityId] or {}
end

function TianShiNaNaConfig:getBubbleCo(activityId, id)
	local dict = lua_activity167_bubble.configDict[activityId]

	if not dict then
		return
	end

	return dict[id]
end

function TianShiNaNaConfig:getTaskByActId(activityId)
	local list = self._taskDict[activityId]

	if not list then
		list = {}

		for _, co in ipairs(lua_activity167_task.configList) do
			if co.activityId == activityId then
				table.insert(list, co)
			end
		end

		self._taskDict[activityId] = list
	end

	return list
end

TianShiNaNaConfig.instance = TianShiNaNaConfig.New()

return TianShiNaNaConfig
