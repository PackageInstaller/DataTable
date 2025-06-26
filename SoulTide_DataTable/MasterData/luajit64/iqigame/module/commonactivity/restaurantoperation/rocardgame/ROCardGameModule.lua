-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROCardGame\\ROCardGameModule.lua

local m = {
	cardGameRankMaxNum = 50,
	cfgCardGameControls = {},
	passCardList = {},
	callBack = Queue.New()
}
local ROCardGameData = require("IQIGame.Module.CommonActivity.RestaurantOperation.ROCardGame.ROCardGameData")

function m.Reload()
	m.cfgCardGameControls = {}
	m.maxLv = 0

	for i, v in pairsCfg(CfgRestaurantOperationMemoryCardControlTable) do
		table.insert(m.cfgCardGameControls, v)

		if m.maxLv < v.Level then
			m.maxLv = v.Level
		end
	end

	table.sort(m.cfgCardGameControls, function(a, b)
		return a.Level < b.Level
	end)

	m.callBack = Queue.New()

	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.GetCardControlDataByLevel(level)
	for i, v in pairs(m.cfgCardGameControls) do
		if v.Level == level then
			return v
		end
	end

	return nil
end

function m.GetPassLevelData(cid)
	for i, v in pairs(m.passCardList) do
		if v.id == cid then
			return v
		end
	end

	return nil
end

function m.GetMaxPassLevel()
	local maxLv = 0

	for i, v in pairs(m.passCardList) do
		local cfgData = CfgRestaurantOperationMemoryCardControlTable[v.id]

		if maxLv < cfgData.Level then
			maxLv = cfgData.Level
		end
	end

	return maxLv
end

function m.GetPassTotalSteps()
	local passNum = 0

	for i, v in pairs(m.passCardList) do
		passNum = passNum + v.cumulativeSteps
	end

	return passNum
end

function m.GetCardGameRanking()
	if not RestaurantOperationModule.IsShow() then
		return
	end

	CenterRankModule.GetRanking(Constant.RankingType.RestaurantOperationCardGameRank, m.cardGameRankMaxNum, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		m.myRanking = myRanking
		m.customData = customData

		EventDispatcher.Dispatch(EventID.ROUpdateCardGameRankEvent)
		log("最新排行数据 " .. m.myRanking)
	end)
end

function m.StartCardGame()
	if not RestaurantOperationModule.IsShow() then
		return
	end

	m.MemoryFlopInfo(function()
		UIModule.Open(Constant.UIControllerName.RestaurantGameCardUI, Constant.UILayer.UI)
	end)
end

function m.CreateNewLevel(lv)
	local nextLv

	if lv ~= nil and lv > 0 then
		nextLv = lv
	else
		local maxLv = m.GetMaxPassLevel()

		nextLv = maxLv + 1
		nextLv = nextLv < m.maxLv and nextLv or m.maxLv
	end

	m.roCardGameData = ROCardGameData.New(nextLv)
end

function m.Shutdown()
	m.RemoveListeners()
	m.callBack:Clear()
end

function m.MemoryFlopInfo(callBack)
	if callBack then
		m.callBack:Enqueue(callBack)
	end

	net_restaurant.memoryFlopInfo()
end

function m.MemoryFlop(time)
	net_restaurant.memoryFlop(m.roCardGameData.cid, m.roCardGameData.stepCounts, time)
end

function m.MemoryFlopInfoResult(restaurantOperationDraw)
	m.passCardList = restaurantOperationDraw

	m.CreateNewLevel()

	if m.callBack.Size > 0 then
		local callBack = m.callBack:Dequeue()

		callBack()
	end
end

function m.MemoryFlopResult(restaurantOperationDraw)
	m.passCardList = restaurantOperationDraw

	m.CreateNewLevel()
	m.GetCardGameRanking()
	EventDispatcher.Dispatch(EventID.ROUpdateCardGameEvent)
end

ROCardGameModule = m
