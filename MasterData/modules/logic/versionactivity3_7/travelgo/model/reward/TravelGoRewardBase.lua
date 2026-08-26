-- chunkname: @modules/logic/versionactivity3_7/travelgo/model/reward/TravelGoRewardBase.lua

module("modules.logic.versionactivity3_7.travelgo.model.reward.TravelGoRewardBase", package.seeall)

local TravelGoRewardBase = pureTable("TravelGoRewardBase")

function TravelGoRewardBase:setData(type, param, eventId)
	self.type = type
	self.param = param
	self.eventId = eventId

	self:onSetData(param)
end

function TravelGoRewardBase:onSetData(param)
	return
end

function TravelGoRewardBase:giveRewards(param)
	return
end

function TravelGoRewardBase:getRewardDesc()
	return
end

function TravelGoRewardBase:getRewardIcon()
	return
end

function TravelGoRewardBase:getRewardBkg()
	return "v3a7_xiaoruiannong_game_magictxtbg"
end

return TravelGoRewardBase
