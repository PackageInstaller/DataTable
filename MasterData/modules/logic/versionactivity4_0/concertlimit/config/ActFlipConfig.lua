-- chunkname: @modules/logic/versionactivity4_0/concertlimit/config/ActFlipConfig.lua

module("modules.logic.versionactivity4_0.concertlimit.config.ActFlipConfig", package.seeall)

local ActFlipConfig = class("ActFlipConfig", BaseConfig)

function ActFlipConfig:ctor()
	self._actConfig = nil
	self._cardConfig = nil
	self._constConfig = nil
	self._rewardConfig = nil
	self._taskConfig = nil
end

function ActFlipConfig:reqConfigNames()
	return {
		"activity246",
		"activity246_card",
		"activity246_const",
		"activity246_reward",
		"activity246_task"
	}
end

function ActFlipConfig:onConfigLoaded(configName, configTable)
	if configName == "activity246" then
		self._actConfig = configTable
	elseif configName == "activity246_card" then
		self._cardConfig = configTable
	elseif configName == "activity246_const" then
		self._constConfig = configTable
	elseif configName == "activity246_reward" then
		self._rewardConfig = configTable
	elseif configName == "activity246_task" then
		self._taskConfig = configTable
	end
end

function ActFlipConfig:getActCos(actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertActFlip

	return self._actConfig.configDict[actId]
end

function ActFlipConfig:getActCo(cardId, actId)
	actId = actId or VersionActivity4_0Enum.ActivityId.ConcertActFlip

	if not self._actConfig.configDict[actId] then
		return nil
	end

	return self._actConfig.configDict[actId][cardId]
end

function ActFlipConfig:getCardCos()
	return self._cardConfig.configDict
end

function ActFlipConfig:getCardCo(cardId)
	return self._cardConfig.configDict[cardId]
end

function ActFlipConfig:getRewardCo(rewardId)
	return self._rewardConfig.configDict[rewardId]
end

function ActFlipConfig:getConstCo(constId)
	return self._constConfig.configDict[constId]
end

function ActFlipConfig:getTaskCo(taskId)
	return self._taskConfig.configDict[taskId]
end

ActFlipConfig.instance = ActFlipConfig.New()

return ActFlipConfig
