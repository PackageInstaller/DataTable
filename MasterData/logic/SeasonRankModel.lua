-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonRankModel.lua

module("logic.extensions.season.model.SeasonRankModel", package.seeall)

local SeasonRankModel = class("SeasonRankModel", BaseModel)

SeasonRankModel.RankType = {
	Reward = 1,
	Challenge = 2,
	Occupied = 3
}
SeasonRankModel.RankTypeToViewName = {
	[SeasonRankModel.RankType.Reward] = ViewName.SeasonRankRewardView,
	[SeasonRankModel.RankType.Challenge] = ViewName.SeasonRankChallengeView,
	[SeasonRankModel.RankType.Occupied] = ViewName.SeasonRankOccupiedView
}

function SeasonRankModel:ctor()
	return
end

function SeasonRankModel:onInit()
	self:onReset()
end

function SeasonRankModel:onReset()
	self._seasonRankRewardData = {}
end

function SeasonRankModel:getRankAllTabViewData(seasonId)
	return SeasonConfig.instance:getRankTabData(seasonId)
end

function SeasonRankModel:refreshSeasonRankData(msg)
	if not self._seasonRankRewardData then
		local data = {}

		data.seasonId = msg.seasonId
		data.rankType = msg.rankType
		data.config = SeasonConfig.instance:getRankConfig(data.seasonId, data.rankType)

		local prizePlanId = data.config.prizePlanId
		local scorePlanId = data.config.scorePlanId

		data.zoneId = msg.zoneId
		data.myRank = msg.myRankInfo.rank
		data.myScore = msg.myRankInfo.score

		if data.rankType == SeasonRankModel.RankType.Challenge then
			data.myScore = SeasonConfig.instance:getRankScoreByRank(scorePlanId, data.myRank)
		end

		data.myOtherData = self:_convertOthereData(data.rankType, msg.myRankInfo.otherValue)
		data.mySubmitTime = msg.myRankInfo.submitTime
		data.seasonModeCfg = SeasonConfig.instance:getSeasonConfigBySeasonId(data.seasonId)
		data.myRewardData = SeasonConfig.instance:getRankRewardByRank(prizePlanId, data.myRank)
		data.rankData = {}

		for _, v in ipairs(msg.infoList) do
			local item = {}

			item.rank = v.rank
			item.score = v.score

			if data.rankType == SeasonRankModel.RankType.Challenge then
				item.score = SeasonConfig.instance:getRankScoreByRank(scorePlanId, item.rank)
			end

			item.otherData = self:_convertOthereData(data.rankType, v.otherValue)
			item.submitTime = v.submitTime
			item.headInfo = v.headInfo
			item.memberInfo = v.memberInfo
			item.rewardData = SeasonConfig.instance:getRankRewardByRank(prizePlanId, item.rank)

			table.insert(data.rankData, item)
		end

		self._seasonRankRewardData = data

		GlobalDispatcher:dispatch(GlobalNotify.SeasonRankUpdate, data)
	end
end

function SeasonRankModel:_convertOthereData(type, str)
	if type == SeasonRankModel.RankType.Reward then
		return nil
	elseif type == SeasonRankModel.RankType.Challenge then
		return checknumber(str)
	elseif type == SeasonRankModel.RankType.Occupied then
		local data = {}
		local jsonData = GameUtil.jsonToTable(str)

		if jsonData then
			for k, v in pairs(jsonData) do
				data[checknumber(k)] = checknumber(v)
			end
		end

		return data
	end

	return nil
end

SeasonRankModel.instance = SeasonRankModel.New()

return SeasonRankModel
