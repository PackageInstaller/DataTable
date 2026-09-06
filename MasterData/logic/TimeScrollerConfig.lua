-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timescroller/config/TimeScrollerConfig.lua

module("logic.extensions.timescroller.config.TimeScrollerConfig", package.seeall)

local TimeScrollerConfig = class("TimeScrollerConfig", BaseConfig)

function TimeScrollerConfig:onInit()
	TimeScrollerConfig.super.onInit(self)

	self._time_scroller_act = nil
	self._time_scroller_ad = nil
	self._time_scroller_progress = nil
end

function TimeScrollerConfig:getNames()
	return {
		"time_scroller_act",
		"time_scroller_ad",
		"time_scroller_progress"
	}
end

function TimeScrollerConfig:handleConfig(name, content)
	if name == "time_scroller_act" then
		self._time_scroller_act = content
	elseif name == "time_scroller_ad" then
		self._time_scroller_ad = content
	elseif name == "time_scroller_progress" then
		self._time_scroller_progress = content
	end
end

function TimeScrollerConfig:getActConfig(actId)
	return self._time_scroller_act[actId]
end

function TimeScrollerConfig:getProgressConfigByValue(progressPlanId, actId, thresholdParam)
	if not self._time_scroller_progress[progressPlanId] then
		local configs = {}

		configs = self._time_scroller_progress[progressPlanId][actId] or {}

		return self._time_scroller_progress[progressPlanId][thresholdParam]
	end
end

function TimeScrollerConfig:getAdArray(adPlanId)
	return self._time_scroller_ad[adPlanId]
end

TimeScrollerConfig.instance = TimeScrollerConfig.New()

return TimeScrollerConfig
