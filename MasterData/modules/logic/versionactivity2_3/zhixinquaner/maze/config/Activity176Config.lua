-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/config/Activity176Config.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.config.Activity176Config", package.seeall)

local Activity176Config = class("Activity176Config", BaseConfig)

function Activity176Config:onInit()
	return
end

function Activity176Config:reqConfigNames()
	return {
		"activity176_bubble",
		"activity176_episode",
		"activity176_dogtag"
	}
end

function Activity176Config:onConfigLoaded(configName, configTable)
	return
end

function Activity176Config:getBubbleCo(activityId, id)
	local dict = lua_activity176_bubble.configDict[activityId]

	if not dict then
		return
	end

	local co = dict[id]

	if not co then
		logError(string.format("纸信圈儿对话配置不存在: activityId = %s, id = %s", activityId, id))

		return
	end

	return co
end

function Activity176Config:getElementCo(activityId, episodeId)
	local dict = lua_activity176_episode.configDict[activityId]

	if not dict then
		return
	end

	local episodeCo = dict[episodeId]

	if episodeCo and episodeCo.elementId ~= 0 then
		return lua_chapter_map_element.configDict[episodeCo.elementId]
	end
end

function Activity176Config:hasElementCo(activityId, episodeId)
	local elementCo = self:getElementCo(activityId, episodeId)

	return elementCo ~= nil
end

function Activity176Config:getEpisodeCoByElementId(activityId, elementId)
	local dict = lua_activity176_episode.configDict[activityId]

	if not dict or not elementId then
		return
	end

	for _, episodeCo in pairs(dict) do
		if episodeCo.elementId == elementId then
			return episodeCo
		end
	end
end

function Activity176Config:getDogTagCfg(activityId, id)
	local cfgDic = lua_activity176_dogtag.configDict[activityId]

	if cfgDic and cfgDic[id] then
		return cfgDic[id]
	end

	logError(string.format("不存活动ID%s ID%s 的狗牌配置表", activityId, id))
end

Activity176Config.instance = Activity176Config.New()

return Activity176Config
