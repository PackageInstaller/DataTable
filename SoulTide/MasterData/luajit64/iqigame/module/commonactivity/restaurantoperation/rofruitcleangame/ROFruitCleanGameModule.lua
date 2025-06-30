-- chunkname: @IQIGame\\Module\\CommonActivity\\RestaurantOperation\\ROFruitCleanGame\\ROFruitCleanGameModule.lua

local m = {
	fruitCleanGameRankMaxNum = 50,
	maxNum = 60,
	cfgFruitCleanGameControls = {},
	passLevelList = {},
	callBack = Queue.New()
}
local ROFruitCleanGameData = require("IQIGame.Module.CommonActivity.RestaurantOperation.ROFruitCleanGame.ROFruitCleanGameData")

function m.Reload()
	m.cfgFruitCleanGameControls = {}
	m.maxLv = 0

	for i, v in pairsCfg(CfgRestaurantOperationFruitCleanControlTable) do
		table.insert(m.cfgFruitCleanGameControls, v)

		if m.maxLv < v.Level then
			m.maxLv = v.Level
		end
	end

	table.sort(m.cfgFruitCleanGameControls, function(a, b)
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

function m.GetMaxPassLevel()
	local maxLv = 0

	for i, v in pairs(m.passLevelList) do
		local cfgData = CfgRestaurantOperationFruitCleanControlTable[v.id]

		if maxLv < cfgData.Level then
			maxLv = cfgData.Level
		end
	end

	return maxLv
end

function m.GetPassTotalTime()
	local passTime = 0

	for i, v in pairs(m.passLevelList) do
		passTime = passTime + v.time
	end

	return passTime
end

function m.GetPassLevelData(cid)
	for i, v in pairs(m.passLevelList) do
		if v.id == cid then
			return v
		end
	end

	return nil
end

function m.GetFruitCleanGameRanking()
	if not RestaurantOperationModule.IsShow() then
		return
	end

	CenterRankModule.GetRanking(Constant.RankingType.RestaurantOperationFruitCleanGameRank, m.fruitCleanGameRankMaxNum, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		m.myRanking = myRanking
		m.customData = customData

		EventDispatcher.Dispatch(EventID.ROUpdateFruitCleanGameRankEvent)
	end)
end

function m.StartCardGame()
	if not RestaurantOperationModule.IsShow() then
		return
	end

	m.LinkGameInfo(function()
		UIModule.Open(Constant.UIControllerName.RestaurantGameConnectUI, Constant.UILayer.UI)
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

	local nextCid

	for i, v in pairsCfg(CfgRestaurantOperationFruitCleanControlTable) do
		if v.Level == nextLv then
			nextCid = v.Id

			break
		end
	end

	m.roFruitCleanGameData = ROFruitCleanGameData.New(nextCid)
end

function m.Shutdown()
	m.RemoveListeners()
	m.callBack:Clear()
end

function m.LinkGameInfo(callBack)
	if callBack then
		m.callBack:Enqueue(callBack)
	end

	net_restaurant.linkGameInfo()
end

function m.LinkGame(id, time)
	net_restaurant.linkGame(id, time)
end

function m.LinkGameInfoResult(restaurantOperationLinkGame)
	m.passLevelList = restaurantOperationLinkGame or {}

	m.CreateNewLevel()

	if m.callBack.Size > 0 then
		local callBack = m.callBack:Dequeue()

		callBack()
	end
end

function m.LinkGameResult(restaurantOperationLinkGame)
	m.passLevelList = restaurantOperationLinkGame

	m.CreateNewLevel()
	m.GetFruitCleanGameRanking()
	EventDispatcher.Dispatch(EventID.ROUpdateFruitCleanGameEvent)
end

ROFruitCleanGameModule = m
