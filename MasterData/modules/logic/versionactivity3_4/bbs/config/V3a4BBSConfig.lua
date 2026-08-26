-- chunkname: @modules/logic/versionactivity3_4/bbs/config/V3a4BBSConfig.lua

module("modules.logic.versionactivity3_4.bbs.config.V3a4BBSConfig", package.seeall)

local V3a4BBSConfig = class("V3a4BBSConfig", BaseConfig)

function V3a4BBSConfig:reqConfigNames()
	return {
		"bbs_main",
		"bbs_story",
		"bbs_dialog"
	}
end

function V3a4BBSConfig:onInit()
	return
end

function V3a4BBSConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function V3a4BBSConfig:getBBSCoListByPostId(actId, postId)
	if lua_bbs_main.configDict[postId] and lua_bbs_main.configDict[postId][actId] then
		return lua_bbs_main.configDict[postId][actId]
	end
end

function V3a4BBSConfig:getTriggerBBSByStory(storyId, stepId)
	if lua_bbs_story.configDict[storyId] and lua_bbs_story.configDict[storyId][stepId] then
		return lua_bbs_story.configDict[storyId][stepId]
	end
end

function V3a4BBSConfig:getBBSDialogCoListById(id)
	if lua_bbs_dialog.configDict[id] then
		return lua_bbs_dialog.configDict[id]
	end
end

V3a4BBSConfig.instance = V3a4BBSConfig.New()

return V3a4BBSConfig
