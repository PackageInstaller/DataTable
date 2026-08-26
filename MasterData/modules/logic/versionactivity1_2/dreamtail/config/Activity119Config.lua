-- chunkname: @modules/logic/versionactivity1_2/dreamtail/config/Activity119Config.lua

module("modules.logic.versionactivity1_2.dreamtail.config.Activity119Config", package.seeall)

local Activity119Config = class("Activity119Config", BaseConfig)

function Activity119Config:reqConfigNames()
	return {
		"activity119_episode",
		"activity119_task"
	}
end

function Activity119Config:onConfigLoaded(configName, configTable)
	return
end

function Activity119Config:onInit()
	self._dict = nil
end

function Activity119Config:getConfig(activityId, tabId)
	if not self._dict then
		self._dict = {}

		for _, episodeCO in ipairs(lua_activity119_episode.configList) do
			self._dict[episodeCO.activityId] = self._dict[episodeCO.activityId] or {}
			self._dict[episodeCO.activityId][episodeCO.tabId] = self._dict[episodeCO.activityId][episodeCO.tabId] or {
				taskList = {},
				tabId = episodeCO.tabId
			}

			local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeCO.id)
			local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

			if chapterConfig.type == DungeonEnum.ChapterType.DreamTailHard then
				self._dict[episodeCO.activityId][episodeCO.tabId].hardCO = episodeCO
			else
				self._dict[episodeCO.activityId][episodeCO.tabId].normalCO = episodeCO
			end
		end

		for _, taskCO in ipairs(lua_activity119_task.configList) do
			self._dict[taskCO.activityId][taskCO.tabId].taskList[taskCO.sort] = taskCO
		end
	end

	return self._dict[activityId][tabId]
end

Activity119Config.instance = Activity119Config.New()

return Activity119Config
