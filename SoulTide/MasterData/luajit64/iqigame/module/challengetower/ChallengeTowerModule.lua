-- chunkname: @IQIGame\\Module\\ChallengeTower\\ChallengeTowerModule.lua

ChallengeTowerModule = {}

function ChallengeTowerModule.ReloadTowerPOD(towerDupPOD)
	ChallengeTowerModule.towerDailyPOD = towerDupPOD
end

function ChallengeTowerModule.UpdateTowerPOD(towerDupPOD)
	ChallengeTowerModule.towerDailyPOD = towerDupPOD
end

function ChallengeTowerModule.GetTowerDataByLayer(layer)
	for i, v in pairsCfg(CfgTowerFloorTable) do
		if v.Floor == layer then
			return v
		end
	end

	return nil
end

function ChallengeTowerModule.GetCfgMaxFloor()
	local maxFloor = 0

	for i, v in pairsCfg(CfgTowerFloorTable) do
		if maxFloor < v.Floor and v.Unlock == 1 then
			maxFloor = v.Floor
		end
	end

	return maxFloor
end

function ChallengeTowerModule.ClimbingTower(towerCid, formationID)
	net_tower.climbingTower(towerCid, formationID)
end

function ChallengeTowerModule.NotifyClimbingTowerComplete(win, dupCid, layerCid, dmgRecords, getItems, maxLayer, nowLayer)
	ChallengeModule.ExitBattle(win, getItems, nil, nil)

	if win then
		ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer = nowLayer

		EventDispatcher.Dispatch(EventID.UpdateTowerEvent, 1)
	else
		EventDispatcher.Dispatch(EventID.UpdateTowerFailure, dupCid)
	end
end
