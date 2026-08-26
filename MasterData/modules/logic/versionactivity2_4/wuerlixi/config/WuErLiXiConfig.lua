-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/config/WuErLiXiConfig.lua

module("modules.logic.versionactivity2_4.wuerlixi.config.WuErLiXiConfig", package.seeall)

local WuErLiXiConfig = class("WuErLiXiConfig", BaseConfig)

function WuErLiXiConfig:onInit()
	self._taskDict = {}
end

function WuErLiXiConfig:reqConfigNames()
	return {
		"activity180_episode",
		"activity180_task",
		"activity180_element"
	}
end

function WuErLiXiConfig:getMapCo(mapId)
	local mapCo = addGlobalModule("modules.configs.wuerlixi.lua_wuerlixi_map_" .. tostring(mapId), "lua_wuerlixi_map_" .. tostring(mapId))

	if not mapCo then
		logError("乌尔里希地图配置不存在" .. mapId)

		return
	end

	return mapCo
end

function WuErLiXiConfig:getEpisodeCoList(activityId)
	if not self._episodeDict then
		self._episodeDict = {}

		for _, v in ipairs(lua_activity180_episode.configList) do
			self._episodeDict[v.activityId] = self._episodeDict[v.activityId] or {}

			table.insert(self._episodeDict[v.activityId], v)
		end
	end

	return self._episodeDict[activityId] or {}
end

function WuErLiXiConfig:getEpisodeCo(activityId, episodeId)
	local episodeCos = self:getEpisodeCoList(activityId)

	for _, v in pairs(episodeCos) do
		if v.episodeId == episodeId then
			return v
		end
	end
end

function WuErLiXiConfig:getTaskByActId(activityId)
	local list = self._taskDict[activityId]

	if not list then
		list = {}

		for _, co in ipairs(lua_activity180_task.configList) do
			if co.activityId == activityId then
				table.insert(list, co)
			end
		end

		self._taskDict[activityId] = list
	end

	return list
end

function WuErLiXiConfig:getElementList()
	return lua_activity180_element.configList
end

function WuErLiXiConfig:getElementCo(elementId)
	return lua_activity180_element.configDict[elementId]
end

WuErLiXiConfig.instance = WuErLiXiConfig.New()

return WuErLiXiConfig
