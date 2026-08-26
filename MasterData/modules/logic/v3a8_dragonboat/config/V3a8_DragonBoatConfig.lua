-- chunkname: @modules/logic/v3a8_dragonboat/config/V3a8_DragonBoatConfig.lua

module("modules.logic.v3a8_dragonboat.config.V3a8_DragonBoatConfig", package.seeall)

local V3a8_DragonBoatConfig = class("V3a8_DragonBoatConfig", Activity241Config)

function V3a8_DragonBoatConfig:getAct241CO()
	return Activity241Config.getAct241CO(self, self:actId())
end

function V3a8_DragonBoatConfig:voteId()
	return Activity241Config.voteId(self, self:actId())
end

function V3a8_DragonBoatConfig:getSignMaxDay()
	return Activity241Config.getSignMaxDay(self, self:actId())
end

function V3a8_DragonBoatConfig:getBonusList()
	return Activity241Config.getBonusList(self, self:actId())
end

function V3a8_DragonBoatConfig:getOptionList()
	return Activity241Config.getOptionList(self, self:actId())
end

function V3a8_DragonBoatConfig:getVoteFinalResultActId()
	return 13817
end

function V3a8_DragonBoatConfig:getVoteFinalRewardItemCO()
	local list = ActivityType101Config.instance:getDayBonusList(self:getVoteFinalResultActId(), 1)

	return list[1]
end

function V3a8_DragonBoatConfig:actId()
	return ActivityEnum.Activity.V3a8_DragonBoatActivity_FullView
end

function V3a8_DragonBoatConfig:getBubbleIntervalSec()
	return ActivityType101Config.instance:getConstAsNum(5, 2)
end

function V3a8_DragonBoatConfig:getDayCO(day)
	return ActivityType101Config.instance:getMoonFestivalByDay(self:actId(), day)
end

function V3a8_DragonBoatConfig:getVoteMaxTimes()
	return ActivityType101Config.instance:getMoonFestivalSignMaxDay(self:actId())
end

function V3a8_DragonBoatConfig:getBubbleDesc(voteCnt, eOp)
	if isDebugBuild then
		assert(eOp)
		assert(voteCnt)
	end

	voteCnt = math.min(voteCnt, self:getVoteMaxTimes())

	local CO = self:getDayCO(voteCnt)

	if not CO then
		return ""
	end

	if eOp == V3a8_DragonBoatEnum.Op.Blue then
		return CO.desc
	else
		return CO.titile
	end
end

V3a8_DragonBoatConfig.instance = V3a8_DragonBoatConfig.New()

return V3a8_DragonBoatConfig
