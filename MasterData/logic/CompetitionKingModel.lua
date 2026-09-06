-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/model/CompetitionKingModel.lua

module("logic.extensions.competitionking.model.CompetitionKingModel", package.seeall)

local CompetitionKingModel = class("CompetitionKingModel", BaseModel)

function CompetitionKingModel:ctor()
	return
end

function CompetitionKingModel:onInit()
	self:onReset()
end

function CompetitionKingModel:onReset()
	self.rankInfosList = {}
	self.gainProgressPrizeIds = {}
end

function CompetitionKingModel:setGainProgressPrizeIds(msg)
	GameUtil.pbToTable(msg.gainProgressPrizeIds, self.gainProgressPrizeIds)
end

function CompetitionKingModel:getGainProgressPrizeIds(id)
	return TableUtil.isHad(self.gainProgressPrizeIds, id)
end

function CompetitionKingModel:setRankInfo(msg)
	GameUtil.pbToTable(msg, self.rankInfosList)
end

function CompetitionKingModel:getRankList()
	if not self.rankInfosList.rankInfos then
		table.sort(self.rankInfosList.rankInfos, function(a, b)
			return a.rank < b.rank
		end)

		return self.rankInfosList.rankInfos
	end
end

function CompetitionKingModel:getMyRank()
	return self.rankInfosList.myRank
end

function CompetitionKingModel:getScore()
	return self.rankInfosList.myScore
end

CompetitionKingModel.instance = CompetitionKingModel.New()

return CompetitionKingModel
