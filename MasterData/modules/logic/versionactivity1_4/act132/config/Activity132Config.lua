-- chunkname: @modules/logic/versionactivity1_4/act132/config/Activity132Config.lua

module("modules.logic.versionactivity1_4.act132.config.Activity132Config", package.seeall)

local Activity132Config = class("Activity132Config", BaseConfig)

function Activity132Config:ctor()
	self.clueDict = {}
	self.collectDict = {}
	self.contentDict = {}
end

function Activity132Config:reqConfigNames()
	return {
		"activity132_clue",
		"activity132_collect",
		"activity132_content"
	}
end

function Activity132Config:onConfigLoaded(configName, configTable)
	local funcName = string.format("on%sConfigLoaded", configName)
	local func = self[funcName]

	if func then
		func(self, configName, configTable)
	end
end

function Activity132Config:onactivity132_clueConfigLoaded(configName, configTable)
	self.clueDict = configTable.configDict
end

function Activity132Config:onactivity132_collectConfigLoaded(configName, configTable)
	self.collectDict = configTable.configDict
end

function Activity132Config:onactivity132_contentConfigLoaded(configName, configTable)
	self.contentDict = configTable.configDict
end

function Activity132Config:getCollectConfig(activityId, collectId)
	local dict = self.collectDict[activityId]
	local cfg = dict and dict[collectId]

	if not cfg then
		logError(string.format("can not find collect! activityId:%s collectId:%s", activityId, collectId))
	end

	return cfg
end

function Activity132Config:getClueConfig(activityId, clueId)
	local actDict = self.clueDict[activityId]
	local cfg = actDict and actDict[clueId]

	if not cfg then
		logError(string.format("can not find clue config! activityId:%s clueId:%s", activityId, clueId))
	end

	return cfg
end

function Activity132Config:getContentConfig(activityId, contentId)
	local actDict = self.contentDict[activityId]
	local cfg = actDict and actDict[contentId]

	if not cfg then
		logError(string.format("can not find content config! activityId:%s contentId:%s", activityId, contentId))
	end

	return cfg
end

function Activity132Config:getCollectDict(activityId)
	return self.collectDict[activityId]
end

Activity132Config.instance = Activity132Config.New()

return Activity132Config
