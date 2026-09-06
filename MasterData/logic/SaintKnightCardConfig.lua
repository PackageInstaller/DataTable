-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightcard/config/SaintKnightCardConfig.lua

module("logic.extensions.saintknightcard.config.SaintKnightCardConfig", package.seeall)

local SaintKnightCardConfig = class("SaintKnightCardConfig", BaseConfig)

SaintKnightCardConfig.PT_ZF = 1
SaintKnightCardConfig.PT_ITEM = 2
SaintKnightCardConfig.PT_FREE = 3

function SaintKnightCardConfig:onInit()
	SaintKnightCardConfig.super.onInit(self)
end

function SaintKnightCardConfig:getNames()
	return {
		"saint_knight_card_activity",
		"saint_knight_card_draw",
		"saint_knight_card_prize",
		"saint_knight_card_common"
	}
end

function SaintKnightCardConfig:handleConfig(name, content)
	if name == "saint_knight_card_activity" then
		self._skcActCfg = content
	elseif name == "saint_knight_card_draw" then
		self._skcDrawCfg = content
	elseif name == "saint_knight_card_prize" then
		self._skcPrizeCfgs = content
	elseif name == "saint_knight_card_common" then
		self._skcCommonCfg = content
	end
end

function SaintKnightCardConfig:getSkcActCfg()
	return self._skcActCfg
end

function SaintKnightCardConfig:getSkcActData(activityId)
	return self._skcActCfg[activityId]
end

function SaintKnightCardConfig:getSkcDrawData(drawPlanId)
	return self._skcDrawCfg[drawPlanId]
end

function SaintKnightCardConfig:getSkcPrizeCfg(prizePlanId)
	return self._skcPrizeCfgs[prizePlanId]
end

function SaintKnightCardConfig:getSkcPrizeCfgById(drawPlanId)
	local drawData = self:getSkcDrawData(drawPlanId)

	return self._skcPrizeCfgs[drawData.prizePlanId]
end

function SaintKnightCardConfig:getSkcPrizeData(prizePlanId, groupId)
	return self._skcPrizeCfgs[prizePlanId][groupId]
end

function SaintKnightCardConfig:getSkcPrizeDataById(drawPlanId, groupId)
	local drawData = self:getSkcDrawData(drawPlanId)

	return self._skcPrizeCfgs[drawData.prizePlanId][groupId]
end

function SaintKnightCardConfig:getSkcCommonValue(key)
	return self._skcCommonCfg[key].value
end

function SaintKnightCardConfig:getSkcRankRaceIdList()
	local value = self:getSkcCommonValue("RANK_KEYS")
	local raceIdList = {}

	for _, raceId in ipairs(string.split(value, ",")) do
		table.insert(raceIdList, checknumber(raceId))
	end

	return raceIdList
end

SaintKnightCardConfig.instance = SaintKnightCardConfig.New()

return SaintKnightCardConfig
