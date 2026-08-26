-- chunkname: @modules/logic/versionactivity1_4/act134/config/Activity134Config.lua

module("modules.logic.versionactivity1_4.act134.config.Activity134Config", package.seeall)

local Activity134Config = class("Activity134Config", BaseConfig)

function Activity134Config:reqConfigNames()
	return {
		"activity134_task",
		"activity134_bonus",
		"activity134_story"
	}
end

function Activity134Config:ctor()
	return
end

function Activity134Config:onConfigLoaded(configName, configTable)
	if configName == "activity134_task" then
		self:_initTaskConfig()
	elseif configName == "activity134_bonus" then
		self:_initBonusConfig()
	elseif configName == "activity134_story" then
		self:_initStoryConfig()
	end
end

function Activity134Config:_initTaskConfig()
	self._taskConfig = {}

	for _, v in ipairs(lua_activity134_task.configList) do
		table.insert(self._taskConfig, v)
	end
end

function Activity134Config:getTaskConfig(id)
	for i, v in ipairs(self._taskConfig) do
		if v.id == id then
			return v
		end
	end
end

function Activity134Config:_initBonusConfig()
	self._bonusConfig = {}

	local index = 1

	for _, v in ipairs(lua_activity134_bonus.configList) do
		self._bonusConfig[index] = v
		index = index + 1
	end
end

function Activity134Config:getBonusAllConfig()
	return self._bonusConfig
end

function Activity134Config:getBonusConfig(id)
	local co = self._bonusConfig[id]

	if co and co.id == id then
		return co
	end

	for i, v in ipairs(self._bonusConfig) do
		if v.id == id then
			return v
		end
	end

	return co
end

function Activity134Config:_initStoryConfig()
	self._storyConfig = {}

	for _, v in ipairs(lua_activity134_story.configList) do
		self._storyConfig[v.id] = v
	end
end

function Activity134Config:getStoryConfig(id)
	local co = self._storyConfig[id]

	if not co then
		logError("[1.4运营活动下半场尘封记录数据错误] 找不到对应的故事配置:id = " .. id)

		return
	end

	return co
end

Activity134Config.instance = Activity134Config.New()

return Activity134Config
