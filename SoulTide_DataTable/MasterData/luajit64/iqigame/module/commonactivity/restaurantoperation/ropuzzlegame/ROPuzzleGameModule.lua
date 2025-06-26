-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROPuzzleGame\\ROPuzzleGameModule.lua

local m = {
	puzzleGameRankMaxNum = 50,
	maxScore = 0,
	callBack = Queue.New()
}
local ROPuzzleGameData = require("IQIGame.Module.CommonActivity.RestaurantOperation.ROPuzzleGame.ROPuzzleGameData")

function m.Reload()
	m.callBack = Queue.New()

	m.AddListeners()
end

function m.InitData()
	if RestaurantOperationModule.GlobalCid > 0 then
		m.cfgPuzzleGameControls = CfgRestaurantOperationPuzzleControlTable[RestaurantOperationModule.GlobalCid]
	end
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
	if not RestaurantOperationModule.IsShow() then
		return
	end

	CenterRankModule.GetRanking(Constant.RankingType.RestaurantOperationPuzzleGameRank, m.cardGameRankMaxNum, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		m.myRanking = myRanking

		EventDispatcher.Dispatch(EventID.ROUpdatePuzzleGameRankEvent)
	end)
end

function m.CreateNewGame()
	m.roPuzzleGameData = ROPuzzleGameData.New(m.cfgPuzzleGameControls)
end

function m.StartPuzzleGame()
	m.PuzzleInfo(function()
		UIModule.Open(Constant.UIControllerName.RestaurantGameBlocksUI, Constant.UILayer.UI)
	end)
end

function m.Shutdown()
	m.RemoveListeners()
	m.callBack:Clear()
end

function m.PuzzleInfo(callBack)
	if callBack then
		m.callBack:Enqueue(callBack)
	end

	net_restaurant.puzzleInfo()
end

function m.Puzzle()
	if m.roPuzzleGameData.score > m.maxScore then
		net_restaurant.puzzle(m.roPuzzleGameData.score)
	end
end

function m.PuzzleInfoResult(score)
	m.maxScore = score

	if m.callBack.Size > 0 then
		local callBack = m.callBack:Dequeue()

		callBack()
	end
end

function m.PuzzleResult(score)
	if score > m.maxScore then
		m.maxScore = score
	end

	m.GetPuzzleGameRanking()
end

ROPuzzleGameModule = m
