-- chunkname: @modules/logic/versionactivity1_4/act136/config/Activity136Config.lua

module("modules.logic.versionactivity1_4.act136.config.Activity136Config", package.seeall)

local Activity136Config = class("Activity136Config", BaseConfig)

function Activity136Config:ctor()
	self.Id2HeroIdDict = {}
end

function Activity136Config:reqConfigNames()
	return {
		"activity136"
	}
end

function Activity136Config:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function Activity136Config:activity136ConfigLoaded(configTable)
	for _, cfg in ipairs(configTable.configList) do
		self.Id2HeroIdDict[cfg.activityId] = string.splitToNumber(cfg.heroIds, "#")
	end
end

function Activity136Config:getCfg(activityId)
	return lua_activity136.configDict[activityId]
end

function Activity136Config:getCfgWithNilError(activityId)
	local cfg = self:getCfg(activityId)

	if not cfg then
		logError("Activity136Config:getCfgWithNilError:cfg nil, id:" .. (activityId or "nil"))
	end

	return cfg
end

function Activity136Config:getSelfSelectCharacterIdList(activityId)
	local result = self.Id2HeroIdDict[activityId]

	if not result then
		result = {}

		logError("Activity136Config:getSelfSelectCharacterIdList error, no heroIds data, id:" .. (activityId or "nil"))
	end

	return result
end

function Activity136Config:getActivityId(fallback)
	return ActivityConfig.instance:getConstAsNum(4, fallback or ActivityEnum.Activity.SelfSelectCharacter)
end

Activity136Config.instance = Activity136Config.New()

return Activity136Config
