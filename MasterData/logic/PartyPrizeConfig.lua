-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partyprize/config/PartyPrizeConfig.lua

module("logic.extensions.onlinetime.config.PartyPrizeConfig", package.seeall)

local PartyPrizeConfig = class("PartyPrizeConfig", BaseConfig)

function PartyPrizeConfig:onInit()
	PartyPrizeConfig.super.onInit(self)

	self._party_prize = nil
	self._party_prize_check_in = nil
	self._party_prize_daily_prize = nil
end

function PartyPrizeConfig:getNames()
	return {
		"party_prize",
		"party_prize_check_in",
		"party_prize_daily_prize"
	}
end

function PartyPrizeConfig:handleConfig(name, content)
	if name == "party_prize" then
		self._party_prize = content
	elseif name == "party_prize_check_in" then
		self._party_prize_check_in = content
	elseif name == "party_prize_daily_prize" then
		self._party_prize_daily_prize = content
	end
end

function PartyPrizeConfig:getActCfg()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(checknumber(GameEnum.ActivityType.PartyPrize))

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item
		end
	end

	return nil
end

function PartyPrizeConfig:getActId()
	local cfg = self:getActCfg()

	if cfg then
		return cfg.activityId
	end

	return -2
end

function PartyPrizeConfig:getEndTime()
	local cfg = self:getActCfg()

	if cfg then
		return cfg.endTime
	end

	return "2021-11-12T05:00:01"
end

function PartyPrizeConfig:getCfg()
	return self._party_prize[self:getActId()]
end

function PartyPrizeConfig:getCheckInCfg(day)
	return self._party_prize_check_in[self:getCfg().checkInPlanId][day]
end

function PartyPrizeConfig:getDailyPrizeCfg(id)
	return self._party_prize_daily_prize[self:getCfg().dailyPrizePlanId][id]
end

local json = require("cjson")

PartyPrizeConfig.instance = PartyPrizeConfig.New()

return PartyPrizeConfig
