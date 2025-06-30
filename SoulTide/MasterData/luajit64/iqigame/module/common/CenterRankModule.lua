-- chunkname: @IQIGame\\Module\\Common\\CenterRankModule.lua

CenterRankModule = {
	GetRankingCallback = Queue.New(),
	GetRankUserDataCallBack = Queue.New(),
	GetRankGoalieCallBack = Queue.New()
}

function CenterRankModule.GetRanking(rankId, count, needUserData, callback)
	if callback ~= nil then
		CenterRankModule.GetRankingCallback:Enqueue(callback)
	end

	net_centerRank.getRank(rankId, count, needUserData)
end

function CenterRankModule.GetRankingResult(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
	if CenterRankModule.GetRankingCallback.Size > 0 then
		local callback = CenterRankModule.GetRankingCallback:Dequeue()

		callback(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
	end
end

function CenterRankModule.GetRankUserData(rankId, lastRanking, rank, callback)
	if callback ~= nil then
		CenterRankModule.GetRankUserDataCallBack:Enqueue(callback)
	end

	net_centerRank.getRankUserData(rankId, lastRanking, rank)
end

function CenterRankModule.GetRankUserDataResult(userData)
	if CenterRankModule.GetRankUserDataCallBack.Size > 0 then
		local callback = CenterRankModule.GetRankUserDataCallBack:Dequeue()

		callback(userData)
	end
end

function CenterRankModule.GetRankGoalie(rankId, rankType, ranking, callback)
	if callback ~= nil then
		CenterRankModule.GetRankGoalieCallBack:Enqueue(callback)
	end

	net_centerRank.getRankGoalie(rankId, rankType, ranking)
end

function CenterRankModule.GetRankGoalieResult(rankingPOD, ranking, rankType)
	if CenterRankModule.GetRankGoalieCallBack.Size > 0 then
		local callback = CenterRankModule.GetRankGoalieCallBack:Dequeue()

		callback(rankingPOD, ranking, rankType)
	end
end
