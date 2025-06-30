-- chunkname: @IQIGame\\Net\\NetCenterRankResponse.lua

function net_centerRank.getRankResult(code, rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
	CenterRankModule.OnGetRankResult(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
end

function net_centerRank.getRankUserDataResult(code, rankId, userData)
	CenterRankModule.OnGetRankUserDataResult(rankId, userData)
end

function net_centerRank.getRankGoalieResult(code, rankId, rankingPOD, ranking, rankType)
	CenterRankModule.OnGetRankGoalieResult(rankId, rankingPOD, ranking, rankType)
end
