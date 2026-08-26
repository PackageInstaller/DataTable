-- chunkname: @modules/logic/versionactivity1_6/v1a6_warmup/config/Activity156Config.lua

module("modules.logic.versionactivity1_6.v1a6_warmup.config.Activity156Config", package.seeall)

local Activity156Config = class("Activity156Config", BaseConfig)

function Activity156Config:ctor()
	self._configTab = nil
	self._channelValueList = {}
	self._episodeCount = nil
end

function Activity156Config:reqConfigNames()
	return {
		"activity125"
	}
end

function Activity156Config:onConfigLoaded(configName, configTable)
	if configName == "activity125" then
		self._configTab = configTable.configDict[ActivityEnum.Activity.Activity1_6WarmUp]
	end
end

function Activity156Config:getActConfig(configName, actId)
	if configName and actId and self._configTab and self._configTab[configName] then
		return self._configTab[configName][actId]
	end

	return nil
end

function Activity156Config:getAct156Config()
	return self._configTab
end

function Activity156Config:getEpisodeDesc(episodeId)
	if self._configTab and self._configTab[episodeId] then
		return self._configTab[episodeId].text
	end
end

function Activity156Config:getEpisodeConfig(id)
	for index, value in ipairs(self._configTab) do
		if value.id == id then
			return value
		end
	end
end

function Activity156Config:getEpisodeOpenDay(episodeId)
	local cfg = self:getEpisodeConfig(episodeId)

	if cfg then
		return cfg.openDay
	end
end

function Activity156Config:getEpisodeRewardConfig(episodeId)
	if self._configTab and self._configTab and self._configTab[episodeId] then
		local rewardBonus = self._configTab[episodeId].bonus

		return (string.split(rewardBonus, "|"))
	end
end

function Activity156Config:getPreEpisodeConfig(episodeId)
	if self._configTab and self._configTab[episodeId] then
		local preEpisodeId = self._configTab[episodeId].preId

		return self._configTab[preEpisodeId]
	end
end

function Activity156Config:getEpisodeCount(actId)
	if not self._episodeCount then
		local episodeCount = tabletool.len(self:getAct156Config(actId))

		self._episodeCount = self._episodeCount

		return self._episodeCount
	end
end

Activity156Config.instance = Activity156Config.New()

return Activity156Config
