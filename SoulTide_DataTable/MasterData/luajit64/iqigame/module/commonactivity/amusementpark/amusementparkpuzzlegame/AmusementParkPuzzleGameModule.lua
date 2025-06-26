-- chunkname: @IQIGame\\Module\\CommonActivity\\AmusementPark\\AmusementParkPuzzleGame\\AmusementParkPuzzleGameModule.lua

local m = {
	maxLv = 0,
	rankType = 1,
	puzzleGameRankMaxNum = 50,
	maxScore = 0,
	callBack = Queue.New()
}
local AmusementParkPuzzleGameData = require("IQIGame.Module.CommonActivity.AmusementPark.AmusementParkPuzzleGame.AmusementParkPuzzleGameData")

function m.Reload()
	m.callBack = Queue.New()

	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.GetAddScore(lines)
	if lines > 0 then
		if lines <= #m.cfgPuzzleGameControls.Score then
			return m.cfgPuzzleGameControls.Score[lines]
		else
			return m.cfgPuzzleGameControls.Score[#m.cfgPuzzleGameControls.Score]
		end
	end

	return 0
end

function m.GetPuzzleGameRanking()
	if not AmusementParkModule.IsShow() then
		return
	end

	CenterRankModule.GetRanking(Constant.RankingType.AmusementParkStackedBlocksRank, m.puzzleGameRankMaxNum, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		m.myRanking = myRanking
		m.rankType = rankType

		EventDispatcher.Dispatch(EventID.APUpdatePuzzleGameRankEvent)
	end)
end

function m.CreateNewGame()
	m.cfgPuzzleGameControls = nil

	for i, v in pairsCfg(CfgAmusementParkPuzzleControlTable) do
		if v.Group == AmusementParkModule.GlobalCid then
			local buildID = v.BuildingLevel[1]
			local needLv = v.BuildingLevel[2]
			local buildData = AmusementParkModule.GetAmusementParkBuildData(buildID)

			if buildData and needLv <= buildData.parkBuildPOD.level then
				if m.cfgPuzzleGameControls == nil then
					m.cfgPuzzleGameControls = v
				elseif m.cfgPuzzleGameControls.Level < v.Level then
					m.cfgPuzzleGameControls = v
				end
			end
		end
	end

	m.apPuzzleGameData = AmusementParkPuzzleGameData.New(m.cfgPuzzleGameControls)
end

function m.StartPuzzleGame()
	m.StackingInfo(function()
		UIModule.Open(Constant.UIControllerName.AmusementParkGameBlocksUI, Constant.UILayer.UI)
	end)
end

function m.Shutdown()
	m.RemoveListeners()
	m.callBack:Clear()
end

function m.StackingInfo(callBack)
	if callBack then
		m.callBack:Enqueue(callBack)
	end

	net_amusementPark.stackingInfo()
end

function m.Stacking()
	net_amusementPark.stacking(m.apPuzzleGameData.cfgPuzzleGameControlData.Level, m.apPuzzleGameData.score)
end

function m.StackingInfoResult(maxLv, score)
	m.maxLv = maxLv
	m.maxScore = score or 0

	if m.callBack.Size > 0 then
		local callBack = m.callBack:Dequeue()

		callBack()
	end
end

function m.StackingResult(maxLv, score)
	if maxLv > m.maxLv then
		m.maxLv = maxLv
		m.maxScore = 0
	end

	if score > m.maxScore then
		m.maxScore = score
	end

	m.GetPuzzleGameRanking()
end

AmusementParkPuzzleGameModule = m
