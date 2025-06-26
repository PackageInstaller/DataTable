-- chunkname: @IQIGame\\Module\\CommonActivity\\FlightChallenge\\FlightGame\\FlightGameModule.lua

local m = {
	flightDistance = 0,
	lastChangeTime = 0,
	specialItemTotalWeight = 0,
	bombNum = 0,
	pickupFlightPointBox = 0,
	totalBlood = 0,
	isGameOver = true,
	monsterDistanceGroupDataDic = {},
	monsterTimerGroupDataDic = {},
	specialItemTab = {}
}

require("IQIGame.Module.CommonActivity.FlightChallenge.FlightGame.FlightGameConstant")

local FlightGameScene = require("IQIGame.Scene.FlightChallenge.FlightGameScene")
local FlightGameMonsterDistanceGroupData = require("IQIGame.Module.CommonActivity.FlightChallenge.FlightGame.FlightGameMonsterDistanceGroupData")
local FlightGameMonsterTimeGroupData = require("IQIGame.Module.CommonActivity.FlightChallenge.FlightGame.FlightGameMonsterTimeGroupData")

function m.Reload()
	m.isGameOver = true

	m.InitData()
	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m:InitData()
	m.monsterDistanceGroupDataDic = {}

	for i, v in pairsCfg(CfgFlightChallengeMonsterCreateDistanceTable) do
		local monsterGroupData = FlightGameMonsterDistanceGroupData.New(v.Id, v.CreateOrder)

		m.monsterDistanceGroupDataDic[v.CreateOrder] = monsterGroupData
	end

	m.monsterTimerGroupDataDic = {}

	for i, v in pairsCfg(CfgFlightChallengeMonsterCreateTimeTable) do
		local monsterTimerGroupData = FlightGameMonsterTimeGroupData.New(v.Id, v.Time)

		m.monsterTimerGroupDataDic[v.Time] = monsterTimerGroupData
	end

	m.specialItemTotalWeight = 0
	m.specialItemTab = {}

	for i, v in pairsCfg(CfgFlightChallengeSpecialItemTable) do
		m.specialItemTotalWeight = m.specialItemTotalWeight + v.Weight

		table.insert(m.specialItemTab, v)
	end
end

function m.StartFlightGame()
	m.EnterFlightGameScene()
end

function m.ExitFlightGame()
	CommonActivitySceneModule.Jump(m.DisposeFlightGameScene, 10901006)
end

function m.EnterFlightGameScene()
	EventDispatcher.Dispatch(EventID.StopBGM)
	CommonActivitySceneModule.EnterScene(CommonActivityVirtualSceneID.FlightGame, m.OnSceneLoaded)
end

function m.OnSceneLoaded()
	m.isGameOver = false
	m.totalBlood = 0
	m.gamePlayerData = FlightChallengeModule.flightGamePlayer[m.startPlayerCid]

	for i, v in pairs(FlightChallengeModule.flightGamePlayer) do
		m.totalBlood = m.totalBlood + v:GetChallengePlayerAttr(FlightGameConstant.Attribute.Flight_Shield_Value)
	end

	m.flightGameScene = FlightGameScene.New()
end

function m.GetBombCfgData()
	for i, v in ipairs(m.specialItemTab) do
		if v.Type == FlightGameConstant.SpecialItemType.SpecialItem_Type_Bomb then
			return v
		end
	end

	return nil
end

function m.ChangeFlightChallengePlayer(cid)
	local nowTime = PlayerModule.GetServerTime()

	if nowTime - m.lastChangeTime < 1 then
		return
	end

	m.lastChangeTime = nowTime
	m.gamePlayerData = FlightChallengeModule.flightGamePlayer[cid]

	if m.isGameOver or m.flightGameScene == nil then
		return
	end

	m.flightGameScene:ChangePlayer(m.gamePlayerData)
end

function m.UseBombs()
	if m.isGameOver or m.flightGameScene == nil then
		return
	end

	if m.bombNum > 0 then
		m.flightGameScene:UseBombs()
	end
end

function m.GameOver()
	FlightChallengeModule.FlightChallengeEnd(m.flightDistance, m.GetFlightPoints())

	m.isGameOver = true

	m.flightGameScene:Clean()

	m.startPlayerCid = nil
end

function m.GetRewardBoxNum()
	return math.floor(m.flightDistance / CfgFlightChallengeControlTable[FlightChallengeModule.GlobalCid].DistanceReward[1])
end

function m.GetFlightPointsByDistance()
	return math.floor(m.flightDistance / CfgFlightChallengeControlTable[FlightChallengeModule.GlobalCid].DistanceScore[1])
end

function m.GetFlightPoints()
	local flightPoint = m.GetFlightPointsByDistance() + m.pickupFlightPointBox

	return flightPoint
end

function m.DisposeFlightGameScene()
	if m.flightGameScene then
		m.flightGameScene:Dispose()
	end

	m.flightGameScene = nil
end

function m.Shutdown()
	m.RemoveListeners()
	m.DisposeFlightGameScene()

	m.lastChangeTime = 0
	m.flightDistance = 0
	m.bombNum = 0
	m.pickupFlightPointBox = 0
	m.currentGroupIndex = 1
	m.isGameOver = true
	m.gamePlayerData = nil
	m.startPlayerCid = nil
end

FlightGameModule = m
