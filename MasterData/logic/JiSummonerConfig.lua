-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/config/JiSummonerConfig.lua

module("logic.extensions.jisummoner.config.JiSummonerConfig", package.seeall)

local JiSummonerConfig = class("JiSummonerConfig", BaseConfig)

function JiSummonerConfig:onInit()
	JiSummonerConfig.super.onInit(self)

	self._activityCfgs = nil
	self._activeCfgs = nil
	self._plotCfgs = nil
end

function JiSummonerConfig:getNames()
	return {
		"ji_activity",
		"ji_activity_active_prize",
		"ji_activity_plot_prize"
	}
end

function JiSummonerConfig:handleConfig(name, content)
	if name == "ji_activity" then
		self._activityCfgs = content
	elseif name == "ji_activity_active_prize" then
		self._activeCfgs = content
	elseif name == "ji_activity_plot_prize" then
		self._plotCfgs = content
	end
end

function JiSummonerConfig:getJiSummonerCfg(actId)
	actId = checknumber(actId)

	if actId <= 0 or self._activityCfgs == nil then
		return nil
	end

	return self._activityCfgs[actId]
end

function JiSummonerConfig:getActivePrizeCfgs(actId)
	actId = checknumber(actId)

	if actId < 1 or self._activeCfgs == nil then
		return nil
	end

	return self._activeCfgs[actId]
end

function JiSummonerConfig:getActivityPlotPrizeCfgs(actId)
	actId = checknumber(actId)

	if actId < 1 or self._plotCfgs == nil then
		return nil
	end

	return self._plotCfgs[actId]
end

function JiSummonerConfig:getOpenActivityId()
	if self._activityCfgs == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.JiSummoner)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item.activityId
		end
	end

	return -3
end

JiSummonerConfig.instance = JiSummonerConfig.New()

return JiSummonerConfig
