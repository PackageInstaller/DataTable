-- chunkname: @IQIGame\\Module\\CenterRankModule\\CenterRankModule.lua

local CenterRankData_ChallengeWorldBoss = require("IQIGame/Module/CenterRankModule/CenterRankData_ChallengeWorldBoss")

CenterRankModule = {
	__rankDataTable = {}
}

function CenterRankModule.Initialize()
	CenterRankModule.__rankDataTable = {}

	CenterRankModule.__RegisterRankDataControl(Constant.CenterRankID.ChallengeWorldBoss, CenterRankData_ChallengeWorldBoss, nil)
end

function CenterRankModule.Reload()
	return
end

function CenterRankModule.ShutDown()
	ForPairs(CenterRankModule.__rankDataTable, function(_, _dataControl)
		_dataControl:Dispose()
	end)

	CenterRankModule.__rankDataTable = nil
end

function CenterRankModule.__RegisterRankDataControl(rankID, rankDataClass, args)
	CenterRankModule.__rankDataTable[rankID] = rankDataClass.New(rankID, rankDataClass, args)
end

function CenterRankModule.GetRankData(rankID, args, callback, callbackArgs)
	local rankDataControl = CenterRankModule.__rankDataTable[rankID]

	if rankDataControl == nil then
		return nil
	end

	rankDataControl:GetRankData(args, callback, callbackArgs)
end

function CenterRankModule.GetRankUserData(rankID, args, callback, callbackArgs)
	local rankDataControl = CenterRankModule.__rankDataTable[rankID]

	if rankDataControl == nil then
		return nil
	end

	rankDataControl:GetRankUserData(args, callback, callbackArgs)
end

function CenterRankModule.GetRankGoalieData(rankID, args, callback, callbackArgs)
	local rankDataControl = CenterRankModule.__rankDataTable[rankID]

	if rankDataControl == nil then
		return nil
	end

	rankDataControl:GetRankGoalieData(args, callback, callbackArgs)
end

function CenterRankModule.GetSelfRankGoalieData(rankID, args, callback, callbackArgs)
	local rankDataControl = CenterRankModule.__rankDataTable[rankID]

	if rankDataControl == nil then
		return nil
	end

	rankDataControl:GetSelfRankGoalieData(args, callback, callbackArgs)
end

function CenterRankModule.SetDataInvalidate(rankID)
	local rankDataControl = CenterRankModule.__rankDataTable[rankID]

	if rankDataControl == nil then
		return nil
	end

	rankDataControl:SetDataInvalidate()
end

function CenterRankModule.OnGetRankResult(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
	local rankDataControl = CenterRankModule.__rankDataTable[rankId]

	if rankDataControl == nil then
		return nil
	end

	rankDataControl:GetRankResult(isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
end

function CenterRankModule.OnGetRankUserDataResult(rankId, userData)
	local rankDataControl = CenterRankModule.__rankDataTable[rankId]

	if rankDataControl == nil then
		return nil
	end

	rankDataControl:GetRankUserDataResult(userData)
end

function CenterRankModule.OnGetRankGoalieResult(rankId, rankingPOD, ranking, rankType)
	local rankDataControl = CenterRankModule.__rankDataTable[rankId]

	if rankDataControl == nil then
		return nil
	end

	rankDataControl:GetRankGoalieResult(rankingPOD, ranking, rankType)
end
