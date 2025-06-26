-- chunkname: @IQIGame\\Module\\CommonActivity\\FlightChallenge\\FlightChallengeModule.lua

local m = {
	GlobalCid = 0,
	isFight = false,
	flightGamePlayer = {},
	flightPlayerUpdateSpend = {},
	flightChallengeBossRankData = {}
}
local FlightChallengePlayerData = require("IQIGame.Module.CommonActivity.FlightChallenge.FlightChallengePlayerData")
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")

function m.Reload(dailyDupPOD)
	m.dailyDupPOD = dailyDupPOD

	if m.dailyDupPOD then
		m.GlobalCid = m.dailyDupPOD.common.openCount

		if m.dailyDupPOD.flightChallengePOD then
			m.InitData()
			FlightGameModule.Reload()
		end
	end

	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[21]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.dailyDupPOD ~= nil and m.dailyDupPOD.common.status ~= 0
end

function m.IsEnter()
	local cfgDailyDupData = CfgDailyDupTable[21]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.dailyDupPOD ~= nil and m.dailyDupPOD.common.status == 1
end

function m.GetExploreUIAsset()
	local cfgFlightChallengeControlData = CfgFlightChallengeControlTable[m.GlobalCid]

	return cfgFlightChallengeControlData.ExploreHallUIBG
end

function m.GetFlightGameCost()
	local cfgFlightChallengeControlData = CfgFlightChallengeControlTable[m.GlobalCid]

	return cfgFlightChallengeControlData.Cost
end

function m.Update(dailyDupPOD)
	m.dailyDupPOD = dailyDupPOD

	if m.IsShow() and m.GlobalCid ~= m.dailyDupPOD.common.openCount then
		m.GlobalCid = m.dailyDupPOD.common.openCount

		m.InitData()
		FlightGameModule.Reload()
	end

	if m.dailyDupPOD.common.status ~= 1 then
		m.EndOfActivity()
	end
end

function m.InitData()
	m.flightGamePlayer = {}
	m.flightPlayerUpdateSpend = {}
	m.flightChallengeBossRankData = {}

	for i, v in pairs(m.dailyDupPOD.flightChallengePOD.flightChallengeMechas) do
		local playerGameData = FlightChallengePlayerData.New(v.id, v)

		m.flightGamePlayer[v.id] = playerGameData

		if m.flightPlayerUpdateSpend[v.id] == nil then
			m.flightPlayerUpdateSpend[v.id] = {}
		end

		for k, cfg in pairsCfg(CfgFlightChallengeElementTable) do
			if cfg.Group == m.GlobalCid and cfg.AttPlayer == v.id then
				table.insert(m.flightPlayerUpdateSpend[v.id], cfg.Id)
			end
		end
	end

	for k, cfg in pairsCfg(CfgFlightChallengeBossRankTable) do
		if cfg.Group == m.GlobalCid then
			table.insert(m.flightChallengeBossRankData, cfg)
		end
	end
end

function m.CheckRedPoint()
	local top = false

	if m.IsShow() then
		for i, v in pairs(m.flightGamePlayer) do
			top = v:CanBeUpgraded()

			if top then
				return top
			end
		end
	end

	return top
end

function m.EndOfActivity()
	if not FlightGameModule.isGameOver then
		FlightGameModule.ExitFlightGame()
	end
end

function m.Shutdown()
	m.GlobalCid = 0
	m.isFight = false

	m.RemoveListeners()

	m.dailyDupPOD = nil
	m.flightGamePlayer = {}
	m.flightPlayerUpdateSpend = {}
	m.flightChallengeBossRankData = {}

	FlightGameModule.Shutdown()
end

function m.FlightChallengeStart(cid)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21057003)

		return
	end

	FlightGameModule.startPlayerCid = cid

	net_flightChallenge.flightChallengeStart()
end

function m.FlightChallengeLevelUp(id)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21057003)

		return
	end

	net_flightChallenge.flightChallengeLevelUp(id)
end

function m.FlightChallengeEnd(distance, integral)
	net_flightChallenge.flightChallengeEnd(distance, integral)
end

function m.FlightChallengeBoss(formationId)
	if not m.IsEnter() then
		NoticeModule.ShowNotice(21057003)

		return
	end

	if m.isFight then
		return
	end

	m.isFight = true

	net_flightChallenge.flightChallengeBoss(formationId)
end

function m.FlightChallengeStartResult()
	FlightGameModule.StartFlightGame()
end

function m.FlightChallengeLevelUpResult(flightChallengeMechaPOD)
	local oldData

	for i, v in pairs(m.dailyDupPOD.flightChallengePOD.flightChallengeMechas) do
		if v.id == flightChallengeMechaPOD.id then
			oldData = table.clone(v)
			m.dailyDupPOD.flightChallengePOD.flightChallengeMechas[i] = flightChallengeMechaPOD
		end
	end

	m.flightGamePlayer[flightChallengeMechaPOD.id].flightChallengeMechaPOD = flightChallengeMechaPOD

	UIModule.Open(Constant.UIControllerName.FlightGameUpTipUI, Constant.UILayer.UI, {
		PlayerData = m.flightGamePlayer[flightChallengeMechaPOD.id],
		OldData = oldData,
		NewData = flightChallengeMechaPOD
	})
	EventDispatcher.Dispatch(EventID.UpdateFlightChallengeEvent)
end

function m.FlightChallengeEndResult(distance, items, integral)
	if distance > FlightChallengeModule.dailyDupPOD.flightChallengePOD.record then
		FlightChallengeModule.dailyDupPOD.flightChallengePOD.record = distance
	end

	UIModule.Open(Constant.UIControllerName.FlightGameSettlementUI, Constant.UILayer.UI, {
		Distance = distance,
		Reward = items,
		FlightPoints = integral
	})
end

function m.FlightChallengeBossResult()
	return
end

function m.NotifyFlightChallengeBossEnd(win, cid, dmgRecords)
	m.isFight = false

	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, {}, nil, dmgRecords)

	rewardData.battleType = 0

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)
end

FlightChallengeModule = m
