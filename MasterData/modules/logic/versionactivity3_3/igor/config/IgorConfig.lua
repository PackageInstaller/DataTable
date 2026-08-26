-- chunkname: @modules/logic/versionactivity3_3/igor/config/IgorConfig.lua

module("modules.logic.versionactivity3_3.igor.config.IgorConfig", package.seeall)

local IgorConfig = class("IgorConfig", BaseConfig)

function IgorConfig:reqConfigNames()
	return {
		"activity220_igor_game",
		"activity220_igor_base",
		"activity220_igor_soldier"
	}
end

function IgorConfig:onInit()
	return
end

function IgorConfig:onConfigLoaded(configName, configTable)
	if configName == "activity220_igor_game" then
		self.gameConfig = configTable
	elseif configName == "activity220_igor_base" then
		self.baseConfig = configTable
	elseif configName == "activity220_igor_soldier" then
		self.soldierConfig = configTable
	end
end

function IgorConfig:getGameConfig(gameId)
	return self.gameConfig.configDict[gameId]
end

function IgorConfig:getBaseConfig(id, level)
	local dict = self.baseConfig.configDict[id]

	return dict and dict[level]
end

function IgorConfig:getSoldierConfig(id)
	return self.soldierConfig.configDict[id]
end

function IgorConfig:getBaseMaxLevel(id)
	local level = 0
	local dict = self.baseConfig.configDict[id]

	if dict then
		for k, v in pairs(dict) do
			level = math.max(level, v.level)
		end
	end

	return level
end

function IgorConfig:getConstValue(id, activityId)
	activityId = activityId or IgorModel.instance:getActivityId()

	return Activity220Config.instance:getConstValue(activityId, id)
end

function IgorConfig:getConstValue2(id, activityId)
	activityId = activityId or IgorModel.instance:getActivityId()

	return Activity220Config.instance:getConstValue2(activityId, id)
end

IgorConfig.instance = IgorConfig.New()

return IgorConfig
