-- chunkname: @modules/logic/versionactivity3_6/warmup/config/V3a6_WarmUpConfig.lua

module("modules.logic.versionactivity3_6.warmup.config.V3a6_WarmUpConfig", package.seeall)

local V3a6_WarmUpConfig = class("V3a6_WarmUpConfig", BaseConfig)

local function _constCO(id)
	return lua_v3a6_warmup_const.configDict[id]
end

local function _dialogCO(id)
	return lua_v3a6_warmup_story.configDict[id]
end

function V3a6_WarmUpConfig:reqConfigNames()
	return {
		"v3a6_warmup_story",
		"v3a6_warmup_const"
	}
end

function V3a6_WarmUpConfig:actId()
	return 13612
end

function V3a6_WarmUpConfig:onConfigLoaded(configName, configTable)
	if configName == "v3a6_warmup_story" then
		self.__v3a6_warmup_dialog = nil

		self:__init_v3a6_warmup_story(configTable)
	end
end

function V3a6_WarmUpConfig:__init_v3a6_warmup_story(configTable)
	if self.__v3a6_warmup_dialog then
		return
	end

	self.__v3a6_warmup_dialog = {}

	for _, CO in ipairs(lua_v3a6_warmup_story.configList) do
		local group = CO.group

		self.__v3a6_warmup_dialog[group] = self.__v3a6_warmup_dialog[group] or {}

		table.insert(self.__v3a6_warmup_dialog[group], CO)
	end

	for _, list in ipairs(self.__v3a6_warmup_dialog) do
		table.sort(list, function(a, b)
			return a.id < b.id
		end)
	end
end

function V3a6_WarmUpConfig:getDialogCountById(dialogId)
	local CO = _dialogCO(dialogId)

	if not CO then
		return 0
	end

	return self:getDialogCount(CO.group)
end

function V3a6_WarmUpConfig:getDialogCount(groupId)
	self:__init_v3a6_warmup_story()

	local groupList = self.__v3a6_warmup_dialog[groupId]

	return (groupList or nil) and (#groupList or 0)
end

function V3a6_WarmUpConfig:getConstNumValue(id)
	local CO = _constCO(id)

	return (CO or nil) and (CO.numValue or nil)
end

function V3a6_WarmUpConfig:getSentenceInBetweenSec()
	return self:getConstNumValue(1) or 1
end

function V3a6_WarmUpConfig:getCutSceneWaitSec()
	return self:getConstNumValue(2) or 1
end

function V3a6_WarmUpConfig:getDialogIntervalY()
	return self:getConstNumValue(3) or 0
end

function V3a6_WarmUpConfig:dialogCOList(groupId)
	self:__init_v3a6_warmup_story()

	return self.__v3a6_warmup_dialog[groupId] or {}
end

V3a6_WarmUpConfig.instance = V3a6_WarmUpConfig.New()

return V3a6_WarmUpConfig
