-- chunkname: @IQIGame\\Net\\NetWorldBossDupResponse.lua

function net_worldBossDup.enterDupResult(code)
	log("enterDupResult:{0}", code)
end

function net_worldBossDup.notifyDup(dupPODs)
	ChallengeWorldBossModule.OnNotifyDup(dupPODs)
end

function net_worldBossDup.notifyFinishDup(fightOverPOD)
	ChallengeWorldBossModule.OnNotifyFinishDup(fightOverPOD)
end
