-- chunkname: @modules/logic/versionactivity3_7/travelgo/model/reward/TravelGoExpReward.lua

module("modules.logic.versionactivity3_7.travelgo.model.reward.TravelGoExpReward", package.seeall)

local TravelGoExpReward = pureTable("TravelGoExpReward", TravelGoRewardBase)

function TravelGoExpReward:onSetData(param)
	self.exp = tonumber(param[1])
end

function TravelGoExpReward:giveRewards(param)
	TravelGoModel.instance:addExp(self.exp)
end

function TravelGoExpReward:getRewardDesc()
	return GameUtil.getSubPlaceholderLuaLang(luaLang("TravelGo_1"), {
		self.exp
	})
end

function TravelGoExpReward:getRewardIcon()
	return "v3a7_xiaoruiannong_game_lvicon"
end

function TravelGoExpReward:getRewardBkg()
	return "v3a7_xiaoruiannong_game_lvtxtbg"
end

return TravelGoExpReward
