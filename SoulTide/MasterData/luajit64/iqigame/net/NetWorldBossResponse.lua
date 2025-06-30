-- chunkname: @IQIGame\\Net\\NetWorldBossResponse.lua

function net_worldBoss.attackResult(code, dupCid)
	return
end

function net_worldBoss.notifyAttackComplete(win, dupCid, layerCid, dmgRecords, getItems, worldBossPOD)
	ChallengeWorldBossModule.NotifyAttackComplete(win, dupCid, layerCid, dmgRecords, getItems, worldBossPOD)
end
