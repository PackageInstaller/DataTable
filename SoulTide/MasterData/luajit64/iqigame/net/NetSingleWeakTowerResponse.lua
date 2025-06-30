-- chunkname: @IQIGame\\Net\\NetSingleWeakTowerResponse.lua

function net_singleWeakTower.fightResult(code)
	SingleWeakTowerMould.FightResult()
end

function net_singleWeakTower.notifyFightComplete(win, dupCid, layerCid, dmgRecords, getItems, nowLayer)
	SingleWeakTowerMould.NotifyFightComplete(win, dupCid, layerCid, dmgRecords, getItems, nowLayer)
end
