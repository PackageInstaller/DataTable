-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventpreview/config/EventPreviewConfig.lua

module("logic.extensions.eventpreview.config.EventPreviewConfig", package.seeall)

local EventPreviewConfig = class("EventPreviewConfig", BaseConfig)

function EventPreviewConfig:onInit()
	EventPreviewConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function EventPreviewConfig:getNames()
	return {
		"upcoming_activity_define",
		"upcoming_activity_daily_prize",
		"upcoming_activity_progress_prize",
		"upcoming_unlock_show_plan",
		"upcoming_unlock_world_prize",
		"upcoming_unlock",
		"upcoming_unlock_person_prize"
	}
end

function EventPreviewConfig:handleConfig(name, content)
	if name == "upcoming_activity_define" then
		self._cofignameCfg = content
	elseif name == "upcoming_activity_daily_prize" then
		self._daily_prize = content
	elseif name == "upcoming_activity_progress_prize" then
		self._progress_prize = content
	elseif name == "upcoming_unlock_show_plan" then
		self._upcoming_unlock_show_plan = content
	elseif name == "upcoming_unlock_world_prize" then
		self._upcoming_unlock_world_prize = content
	elseif name == "upcoming_unlock" then
		self._upcoming_unlock = content
	elseif name == "upcoming_unlock_person_prize" then
		self._upcoming_unlock_person_prize = content
	end
end

function EventPreviewConfig:getCfgById(id)
	return self._cofignameCfg[id]
end

function EventPreviewConfig:getDailyPrize(id)
	local cfg = self:getCfgById(id)

	if cfg.dailyPrizePlanId then
		return self._daily_prize[cfg.dailyPrizePlanId]
	end

	return nil
end

function EventPreviewConfig:getProgressPrize(id)
	local cfg = self:getCfgById(id)

	if cfg.progressPrizePlanId then
		return self._progress_prize[cfg.progressPrizePlanId]
	end

	return nil
end

function EventPreviewConfig:getIsInTime(id)
	local cfg = self:getCfgById(id)

	if GameUtil.checkIsInTimePeriod(cfg.gainPrizeStartTime, cfg.gainPrizeEndTime) then
		return true
	end

	return false
end

function EventPreviewConfig:getUnlockActCfgs(actId)
	return self._upcoming_unlock[actId]
end

function EventPreviewConfig:getUnlockShowCfgs(actId)
	return self._upcoming_unlock_show_plan[actId]
end

function EventPreviewConfig:getUnlockPersonPrizeCfgs(actId)
	return self._upcoming_unlock_person_prize[actId]
end

function EventPreviewConfig:getUnlockWorldPrizeCfgs(actId)
	return self._upcoming_unlock_world_prize[actId]
end

EventPreviewConfig.instance = EventPreviewConfig.New()

return EventPreviewConfig
