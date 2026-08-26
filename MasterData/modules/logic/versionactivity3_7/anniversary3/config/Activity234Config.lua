-- chunkname: @modules/logic/versionactivity3_7/anniversary3/config/Activity234Config.lua

module("modules.logic.versionactivity3_7.anniversary3.config.Activity234Config", package.seeall)

local Activity234Config = class("Activity234Config", BaseConfig)

function Activity234Config:ctor()
	self._constConfig = {}
	self._ctrlConfig = {}
	self._weekRolesConfig = {}
	self._bonusConfig = {}
	self._boxGiftConfig = {}
	self._episodeConfig = {}
	self._npcConfig = {}
end

function Activity234Config:reqConfigNames()
	return {
		"activity234_const",
		"activity234_control",
		"activity234_gameroles",
		"activity234_milestone_bonus",
		"activity234_episode",
		"activity234_giftbox",
		"activity234_npc"
	}
end

function Activity234Config:onConfigLoaded(configName, configTable)
	if configName == "activity234_const" then
		self._constConfig = configTable
	elseif configName == "activity234_control" then
		self._ctrlConfig = configTable
	elseif configName == "activity234_gameroles" then
		self._weekRolesConfig = configTable
	elseif configName == "activity234_milestone_bonus" then
		self._bonusConfig = configTable
	elseif configName == "activity234_episode" then
		self._episodeConfig = configTable
	elseif configName == "activity234_giftbox" then
		self._boxGiftConfig = configTable
	elseif configName == "activity234_npc" then
		self._npcConfig = configTable
	end
end

function Activity234Config:getConstCos()
	return self._constConfig.configDict
end

function Activity234Config:getConstValue(id)
	if not self._constConfig.configDict[id] then
		return ""
	end

	return self._constConfig.configDict[id].strValue
end

function Activity234Config:getConstNumberValue(id)
	if not self._constConfig.configDict[id] then
		return 0
	end

	local value = tonumber(self._constConfig.configDict[id].strValue)

	return value or 0
end

function Activity234Config:getCtrlCo(actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	return self._ctrlConfig.configDict[actId]
end

function Activity234Config:getWeekRoleCo(week)
	return self._weekRolesConfig.configDict[week]
end

function Activity234Config:getBonusCos(actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	return self._bonusConfig.configDict[actId]
end

function Activity234Config:getBonusCo(bonusId, actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	return self._bonusConfig.configDict[actId][bonusId]
end

function Activity234Config:getEpisodeCo(episodeId)
	return self._episodeConfig.configDict[episodeId]
end

function Activity234Config:getBoxGiftCos()
	return self._boxGiftConfig.configDict
end

function Activity234Config:getBoxGiftCo(giftId)
	return self._boxGiftConfig.configDict[giftId]
end

function Activity234Config:getNpcCo(npcId)
	return self._npcConfig.configDict[npcId]
end

Activity234Config.instance = Activity234Config.New()

return Activity234Config
