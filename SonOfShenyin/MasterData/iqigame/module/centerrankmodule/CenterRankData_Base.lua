-- chunkname: @IQIGame\\Module\\CenterRankModule\\CenterRankData_Base.lua

local RankDataBase = {
	rankID = 0
}

function RankDataBase.New(rankID, rankDataClass, args)
	local obj = Clone(rankDataClass)

	obj:__Base_Init(rankID, args)

	return obj
end

function RankDataBase:__Base_Init(rankID, args)
	self.rankID = rankID
	self.rankData = nil
	self.getRankCallbackQueue = Queue.New()
	self.getRankUserDataCallbackQueue = Queue.New()
	self.getRankGoalieDataCallbackQueue = Queue.New()

	self:__OnInit(args)
end

function RankDataBase:__OnInit(args)
	return
end

function RankDataBase:GetRankData(args, callback, callbackArgs)
	if self:__CheckRankDataValid() then
		if callback == nil then
			return
		end

		callback(self.rankData, callbackArgs)

		return
	end

	local callBackQueueData = {}

	callBackQueueData.callback = callback
	callBackQueueData.args = callbackArgs

	if self.getRankCallbackQueue.Size == 0 then
		self:__OnGetRankData(args)
	end

	self.getRankCallbackQueue:Enqueue(callBackQueueData)
end

function RankDataBase:__CheckRankDataValid()
	return false
end

function RankDataBase:SetRankDataInvalidate()
	self.rankData = nil
end

function RankDataBase:__OnGetRankData(args)
	net_centerRank.getRank(self.rankID, args.count, args.needUserData)
end

function RankDataBase:GetRankResult(isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
	self:__OnProcessRankData(isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
end

function RankDataBase:__OnProcessRankData(isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
	self.rankData = {}
	self.rankData.isOpen = isOpen
	self.rankData.rankings = rankings
	self.rankData.lastRankings = lastRankings
	self.rankData.myRanking = myRanking
	self.rankData.myScore = myScore
	self.rankData.customData = customData
	self.rankData.rankType = rankType

	self:__OnApplyRankData(self.rankData)
end

function RankDataBase:__OnApplyRankData(rankData)
	local cnt = self.getRankCallbackQueue.Size

	ForArrayByCount(1, cnt, 1, function(_)
		local queueData = self.getRankCallbackQueue:Dequeue()

		if queueData.callback == nil then
			return
		end

		queueData.callback(rankData, queueData.args)
	end)
end

function RankDataBase:GetRankUserData(args, callback, callbackArgs)
	local dataValid, data = self:__CheckRankUserDataValid(args)

	if dataValid then
		if callback == nil then
			return
		end

		callback(data, callbackArgs)

		return
	end

	local callBackQueueData = {}

	callBackQueueData.callback = callback
	callBackQueueData.args = callbackArgs

	if self.getRankUserDataCallbackQueue.Size == 0 then
		self:__OnGetRankUserData(args)
	end

	self.getRankUserDataCallbackQueue:Enqueue(callBackQueueData)
end

function RankDataBase:__CheckRankUserDataValid(args)
	return false, nil
end

function RankDataBase:SetRankUserDataInvalidate()
	return
end

function RankDataBase:__OnGetRankUserData(args)
	net_centerRank.getRankUserData(self.rankID, args.lastRanking, args.rank)
end

function RankDataBase:GetRankUserDataResult(userData)
	self:__OnProcessRankUserData(userData)
end

function RankDataBase:__OnProcessRankUserData(userData)
	self:__OnApplyRankUserData(userData)
end

function RankDataBase:__OnApplyRankUserData(userData)
	local cnt = self.getRankUserDataCallbackQueue.Size

	ForArrayByCount(1, cnt, 1, function(_)
		local queueData = self.getRankUserDataCallbackQueue:Dequeue()

		if queueData.callback == nil then
			return
		end

		queueData.callback(userData, queueData.args)
	end)
end

function RankDataBase:GetRankGoalieData(args, callback, callbackArgs)
	local dataValid, data = self:__CheckRankGoalieDataValid(args)

	if dataValid then
		if callback == nil then
			return
		end

		callback(data, callbackArgs)

		return
	end

	local callBackQueueData = {}

	callBackQueueData.callback = callback
	callBackQueueData.args = callbackArgs

	if self.getRankGoalieDataCallbackQueue.Size == 0 then
		self:__OnGetRankGoalieData(args)
	end

	self.getRankGoalieDataCallbackQueue:Enqueue(callBackQueueData)
end

function RankDataBase:__CheckRankGoalieDataValid(args)
	return false, nil
end

function RankDataBase:SetRankGoalieDataInvalidate()
	return
end

function RankDataBase:__OnGetRankGoalieData(args)
	net_centerRank.getRankGoalie(self.rankID, args.rankType, args.rank)
end

function RankDataBase:GetRankGoalieResult(rankingPOD, ranking, rankType)
	self:__OnProcessRankGoalieData(rankingPOD, ranking, rankType)
end

function RankDataBase:__OnProcessRankGoalieData(rankingPOD, ranking, rankType)
	local goalieData = {}

	goalieData.rankingPOD = rankingPOD
	goalieData.ranking = ranking
	goalieData.rankType = rankType

	self:__OnApplyRankGoalieData(goalieData)
end

function RankDataBase:__OnApplyRankGoalieData(goalieData)
	local cnt = self.getRankGoalieDataCallbackQueue.Size

	ForArrayByCount(1, cnt, 1, function(_)
		local queueData = self.getRankGoalieDataCallbackQueue:Dequeue()

		if queueData.callback == nil then
			return
		end

		queueData.callback(goalieData, queueData.args)
	end)
end

function RankDataBase:GetSelfRankGoalieData(args, callback, callbackArgs)
	local getRankCallbackData = {}

	getRankCallbackData.callback = callback
	getRankCallbackData.callbackArgs = TryToTable(callbackArgs, false, {})

	self:GetRankData(args, function(_rankData, _args)
		self:__GetRankCallback_GetSelfRankGoalieData(_rankData, _args)
	end, getRankCallbackData)
end

function RankDataBase:__GetRankCallback_GetSelfRankGoalieData(rankData, args)
	logError("这个方法必须要重写，需要根据业务去判断自己的上一级数据")
end

function RankDataBase:SetDataInvalidate()
	self:SetRankDataInvalidate()
	self:SetRankUserDataInvalidate()
	self:SetRankGoalieDataInvalidate()
end

function RankDataBase:Dispose()
	self.rankData = nil

	self.getRankCallbackQueue:Clear()

	self.getRankCallbackQueue = nil

	self.getRankUserDataCallbackQueue:Clear()

	self.getRankCallbackQueue = nil

	self.getRankGoalieDataCallbackQueue:Clear()

	self.getRankGoalieDataCallbackQueue = nil

	self:__OnDispose()
end

function RankDataBase:__OnDispose()
	return
end

return RankDataBase
