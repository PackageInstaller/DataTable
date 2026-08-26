-- chunkname: @modules/logic/versionactivity1_4/act135/config/Activity135Config.lua

module("modules.logic.versionactivity1_4.act135.config.Activity135Config", package.seeall)

local Activity135Config = class("Activity135Config", BaseConfig)

function Activity135Config:ctor()
	self.rewardDict = {}
end

function Activity135Config:reqConfigNames()
	return {
		"activity135_reward"
	}
end

function Activity135Config:onConfigLoaded(configName, configTable)
	local funcName = string.format("on%sConfigLoaded", configName)
	local func = self[funcName]

	if func then
		func(self, configName, configTable)
	end
end

function Activity135Config:onactivity135_rewardConfigLoaded(configName, configTable)
	self.rewardDict = configTable.configDict
end

function Activity135Config:getEpisodeCos(episodeId)
	return self.rewardDict[episodeId]
end

Activity135Config.instance = Activity135Config.New()

return Activity135Config
