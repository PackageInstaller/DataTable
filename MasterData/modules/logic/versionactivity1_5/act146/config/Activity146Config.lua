-- chunkname: @modules/logic/versionactivity1_5/act146/config/Activity146Config.lua

module("modules.logic.versionactivity1_5.act146.config.Activity146Config", package.seeall)

local Activity146Config = class("Activity146Config", BaseConfig)

function Activity146Config:ctor()
	self._configList = nil
end

function Activity146Config:reqConfigNames()
	return {
		"activity146"
	}
end

function Activity146Config:onConfigLoaded(configName, configTable)
	if configName == "activity146" then
		self._configList = configTable.configDict
	end
end

function Activity146Config:getEpisodeConfig(actId, episodeId)
	return self._configList[actId][episodeId]
end

function Activity146Config:getAllEpisodeConfigs(actId)
	return self._configList and self._configList[actId]
end

function Activity146Config:getEpisodeRewardConfig(actId, episodeId)
	if self._configList and self._configList[actId] and self._configList[actId][episodeId] then
		local rewardBonus = self._configList[actId][episodeId].bonus

		return (string.split(rewardBonus, "|"))
	end
end

function Activity146Config:getEpisodeDesc(actId, episodeId)
	if self._configList and self._configList[actId] and self._configList[actId][episodeId] then
		return self._configList[actId][episodeId].text
	end
end

function Activity146Config:getEpisodeTitle(actId, episodeId)
	if self._configList and self._configList[actId] and self._configList[actId][episodeId] then
		return self._configList[actId][episodeId].name
	end
end

function Activity146Config:getPreEpisodeConfig(actId, episodeId)
	if self._configList and self._configList[actId] and self._configList[actId][episodeId] then
		local preEpisodeId = self._configList[actId][episodeId].preId

		return self._configList[actId][preEpisodeId]
	end
end

function Activity146Config:getEpisodePhoto(actId, episodeId)
	if self._configList and self._configList[actId] and self._configList[actId][episodeId] then
		return self._configList[actId][episodeId].photo
	end
end

function Activity146Config:getEpisodeInteractType(actId, episodeId)
	if self._configList and self._configList[actId] and self._configList[actId][episodeId] then
		return self._configList[actId][episodeId].interactType or 1
	end
end

Activity146Config.instance = Activity146Config.New()

return Activity146Config
