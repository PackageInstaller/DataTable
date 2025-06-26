-- chunkname: @IQIGame\\Module\\SingleWeakTower\\SingleWeakTowerModule.lua

local m = {
	isFight = false,
	cfgSingleWeakTowerDataTab = {}
}
local ChallengeRewardData = require("IQIGame.Module.Challenge.ChallengeRewardData")

function m.Reload(dailyDupPOD)
	m.dailyDupPOD = dailyDupPOD
	m.cfgSingleWeakTowerDataTab = {}

	for i, v in pairsCfg(CfgSingleWeakTowerFloorTable) do
		if m.cfgSingleWeakTowerDataTab[v.Type] == nil then
			m.cfgSingleWeakTowerDataTab[v.Type] = {}
		end

		m.cfgSingleWeakTowerDataTab[v.Type][v.Floor] = v
	end

	m.AddListeners()
end

function m.Update(dailyDupPOD)
	m.dailyDupPOD = dailyDupPOD
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.IsShow()
	local cfgDailyDupData = CfgDailyDupTable[20]

	return UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction) and m.dailyDupPOD ~= nil and m.dailyDupPOD.common.status ~= 0
end

function m.GetCfgDailyDupData()
	if m.dailyDupPOD then
		local cfgDailyDupData = CfgDailyDupTable[m.dailyDupPOD.common.cid]

		if cfgDailyDupData.Type == Constant.ChallengeType.ChallengeSingleWeakTower then
			return cfgDailyDupData
		end
	end

	return nil
end

function m.GetPassMaxFloorByType(type)
	local floor = 0

	if m.dailyDupPOD and m.dailyDupPOD.singleWeakTower then
		floor = m.dailyDupPOD.singleWeakTower.towerFloor[type]
		floor = floor == nil and 0 or floor
	end

	return floor
end

function m.Shutdown()
	m.dailyDupPOD = nil
	m.isFight = false

	m.RemoveListeners()
end

function m.Fight(towerCid, formationID)
	if m.isFight then
		return
	end

	net_singleWeakTower.fight(towerCid, formationID)

	m.isFight = true
end

function m.FightResult()
	return
end

function m.NotifyFightComplete(win, dupCid, layerCid, dmgRecords, getItems, nowLayer)
	m.isFight = false

	MainCityBattleModule.Instance:QuitBattle()

	local rewardData = ChallengeRewardData.New(1, win, getItems, nil, dmgRecords)

	UIModule.Open(Constant.UIControllerName.ChallengeRewardUI, Constant.UILayer.UI, rewardData)

	if win and m.dailyDupPOD.common.cid == dupCid then
		local cfgLayerData = CfgSingleWeakTowerFloorTable[layerCid]

		if m.dailyDupPOD.singleWeakTower == nil then
			m.dailyDupPOD.singleWeakTower = {}
		end

		if m.dailyDupPOD.singleWeakTower.towerFloor == nil then
			m.dailyDupPOD.singleWeakTower.towerFloor = {}
		end

		local lastLay = m.dailyDupPOD.singleWeakTower.towerFloor[cfgLayerData.Type]

		lastLay = lastLay == nil and 0 or lastLay

		if lastLay < nowLayer then
			m.dailyDupPOD.singleWeakTower.towerFloor[cfgLayerData.Type] = nowLayer
		end
	end

	EventDispatcher.Dispatch(EventID.UpdateSingleWeakTowerEvent)
end

SingleWeakTowerMould = m
