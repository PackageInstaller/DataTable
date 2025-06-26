-- chunkname: @IQIGame\\Net\\NetCenterRankResponse.lua

function net_centerRank.getRankResult(code, rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
	CenterRankModule.GetRankingResult(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
end

function net_centerRank.getRankUserDataResult(code, userData)
	CenterRankModule.GetRankUserDataResult(userData)
end

function net_centerRank.getRankGoalieResult(code, rankingPOD, ranking, rankType)
	CenterRankModule.GetRankGoalieResult(rankingPOD, ranking, rankType)
end
