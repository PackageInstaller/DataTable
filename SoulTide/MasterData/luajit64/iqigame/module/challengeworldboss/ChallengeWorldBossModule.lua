-- chunkname: @IQIGame\\Module\\ChallengeWorldBoss\\ChallengeWorldBossModule.lua

ChallengeWorldBossModule = {
	isFight = false
}

function ChallengeWorldBossModule.ReloadWorldBossPOD(worldBossDupPOD)
	ChallengeWorldBossModule.worldBossDupPOD = worldBossDupPOD
	ChallengeWorldBossModule.bossOrders = {}

	for i, v in pairsCfg(CfgWorldBossTable) do
		if table.indexOf(ChallengeWorldBossModule.bossOrders, v.BossOrder) == -1 then
			table.insert(ChallengeWorldBossModule.bossOrders, v.BossOrder)
		end
	end

	table.sort(ChallengeWorldBossModule.bossOrders, function(a, b)
		return a < b
	end)
	ChallengeWorldBossModule.CheckRedPoint()
end

function ChallengeWorldBossModule.GetWorldBossData()
	return CfgWorldBossTable[ChallengeWorldBossModule.worldBossDupPOD.worldBossPOD.bossCid]
end

function ChallengeWorldBossModule.GetNextWorldBossData()
	local cfgWordBoss = ChallengeWorldBossModule.GetWorldBossData()
	local typePos = table.indexOf(ChallengeWorldBossModule.bossOrders, cfgWordBoss.BossOrder)
	local nextPos = typePos + 1

	if nextPos > #ChallengeWorldBossModule.bossOrders then
		nextPos = 1
	end

	local nextOrder = ChallengeWorldBossModule.bossOrders[nextPos]

	for i, v in pairsCfg(CfgWorldBossTable) do
		if v.BossOrder == nextOrder then
			local myLv = ChallengeWorldBossModule.worldBossDupPOD.worldBossPOD.typeLevel[v.BossType] or 1

			if myLv == v.BossLevel then
				return v
			end
		end
	end

	return nil
end

function ChallengeWorldBossModule.CheckRedPoint()
	if ChallengeWorldBossModule.worldBossDupPOD then
		local openCount = ChallengeWorldBossModule.worldBossDupPOD.common.openCount
		local key = PlayerModule.PlayerInfo.baseInfo.pid .. openCount
		local openState = PlayerPrefsUtil.GetInt(key, Constant.PlayerPrefsConst.Open_ChallengeWorldBoss)

		if openState == 0 then
			return true
		end
	end

	return false
end

function ChallengeWorldBossModule.SaveOpenWorldBossPrefs()
	if ChallengeWorldBossModule.worldBossDupPOD then
		local openCount = ChallengeWorldBossModule.worldBossDupPOD.common.openCount
		local key = PlayerModule.PlayerInfo.baseInfo.pid .. openCount

		PlayerPrefsUtil.SetInt(key, Constant.PlayerPrefsConst.Open_ChallengeWorldBoss, 1)
		EventDispatcher.Dispatch(EventID.UpdateWoldBossRedPoint)
	end
end

function ChallengeWorldBossModule.Shutdown()
	ChallengeWorldBossModule.isFight = false
end

function ChallengeWorldBossModule.Attack(dupCid, formationID, clearCD, boosCid)
	if ChallengeWorldBossModule.isFight then
		return
	end

	net_worldBoss.attack(dupCid, formationID, clearCD, boosCid)

	ChallengeWorldBossModule.isFight = true
end

function ChallengeWorldBossModule.GetRanking(count, callback)
	CenterRankModule.GetRanking(Constant.RankingType.WorldBossRank, count, false, callback)
end

function ChallengeWorldBossModule.GetRankUserData(lastRanking, rank, callBack)
	CenterRankModule.GetRankUserData(Constant.RankingType.WorldBossRank, lastRanking, rank, callBack)
end

function ChallengeWorldBossModule.GetRankGoalie(rankType, ranking, callback)
	CenterRankModule.GetRankGoalie(Constant.RankingType.WorldBossRank, rankType, ranking, callback)
end

function ChallengeWorldBossModule.NotifyAttackComplete(win, dupCid, layerCid, dmgRecords, getItems, worldBossPOD)
	ChallengeWorldBossModule.isFight = false

	ChallengeModule.ExitBattle(win, getItems, nil, dmgRecords)

	local dailyDupPOD = DailyDupModule.GetDailyDupPOD(dupCid)

	if worldBossPOD ~= nil then
		dailyDupPOD.worldBossPOD = worldBossPOD
	end

	ChallengeWorldBossModule.worldBossDupPOD = dailyDupPOD

	local cfgDailyDupData = CfgDailyDupTable[dailyDupPOD.common.cid]

	EventDispatcher.Dispatch(EventID.UpdateWorldBossBattleEnd, cfgDailyDupData)
end

function ChallengeWorldBossModule.UpdateWorldBossDupPOD(dailyDupPOD)
	ChallengeWorldBossModule.worldBossDupPOD = dailyDupPOD

	local cfgDailyDupData = CfgDailyDupTable[dailyDupPOD.common.cid]

	EventDispatcher.Dispatch(EventID.UpdateWorldBossData, cfgDailyDupData)
	EventDispatcher.Dispatch(EventID.UpdateWoldBossRedPoint)
end
