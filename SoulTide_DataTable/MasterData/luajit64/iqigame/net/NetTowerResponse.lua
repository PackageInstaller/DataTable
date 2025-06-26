-- chunkname: @IQIGame\\Net\\NetTowerResponse.lua

function net_tower.climbingTowerResult(code)
	return
end

function net_tower.notifyClimbingTowerComplete(win, dupCid, layerCid, dmgRecords, getItems, maxLayer, nowLayer)
	ChallengeTowerModule.NotifyClimbingTowerComplete(win, dupCid, layerCid, dmgRecords, getItems, maxLayer, nowLayer)
end
