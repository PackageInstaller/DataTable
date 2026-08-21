-- chunkname: @IQIGame\\Module\\DailyDup\\DailyDupModule.lua

DailyDupModule = {}

function DailyDupModule.Reload(dailyDups)
	DailyDupModule.DailyDupPODList = dailyDups

	local challengeDupPODList = {}
	local worldBossDupPOD, towerDupPOD, rpgMazePOD, passDupPOD, lunaBattlePOD, dreamlandPOD, challengeDataPOD, dualTeamExplorePOD, magicTowerPOD, miniGalGameDataPOD, evilErosionPOD, abyssPlusPOD, guildChallengePOD, miningDupPOD, singleWeakTower, flightChallengeDupPOD, guildTrainingPOD, restaurantOperationPOD, placeGamePOD, amusementParkPOD, survivalPOD, horizontalRPGPOD, fishingActivityDupPOD

	for i, dailyDupPOD in pairs(DailyDupModule.DailyDupPODList) do
		if dailyDupPOD.common ~= nil then
			if dailyDupPOD.challengePOD ~= nil then
				table.insert(challengeDupPODList, dailyDupPOD)
			end

			if dailyDupPOD.worldBossPOD ~= nil then
				worldBossDupPOD = dailyDupPOD
			end

			if dailyDupPOD.towerPOD ~= nil then
				towerDupPOD = dailyDupPOD
			end

			if dailyDupPOD.rpgMazePOD ~= nil then
				rpgMazePOD = dailyDupPOD
			end

			if dailyDupPOD.battlePassesPOD ~= nil then
				passDupPOD = dailyDupPOD
			end

			if dailyDupPOD.lunaBattleLineDataPOD ~= nil then
				lunaBattlePOD = dailyDupPOD
			end

			if dailyDupPOD.dreamMapPOD ~= nil then
				dreamlandPOD = dailyDupPOD
			end

			if dailyDupPOD.challengeDataPOD ~= nil then
				challengeDataPOD = dailyDupPOD
			end

			if dailyDupPOD.dualTeamExplorePOD ~= nil then
				dualTeamExplorePOD = dailyDupPOD
			end

			if dailyDupPOD.magicTowerPOD ~= nil then
				magicTowerPOD = dailyDupPOD
			end

			if dailyDupPOD.miniGalGameDataPOD ~= nil then
				miniGalGameDataPOD = dailyDupPOD
			end

			if dailyDupPOD.evilErosionPOD ~= nil then
				evilErosionPOD = dailyDupPOD
			end

			if dailyDupPOD.abyssPlusPOD ~= nil then
				abyssPlusPOD = dailyDupPOD
			end

			if dailyDupPOD.guildChallengePOD ~= nil then
				guildChallengePOD = dailyDupPOD
			end

			if dailyDupPOD.miningPOD ~= nil then
				miningDupPOD = dailyDupPOD
			end

			if dailyDupPOD.singleWeakTower ~= nil or dailyDupPOD.common.cid == 20 and dailyDupPOD.common.status == 1 then
				singleWeakTower = dailyDupPOD
			end

			if dailyDupPOD.flightChallengePOD ~= nil then
				flightChallengeDupPOD = dailyDupPOD
			end

			if dailyDupPOD.guildTrainingPOD then
				guildTrainingPOD = dailyDupPOD
			end

			if dailyDupPOD.restaurantOperationPOD then
				restaurantOperationPOD = dailyDupPOD
			end

			if dailyDupPOD.placeGamePOD then
				placeGamePOD = dailyDupPOD
			end

			if dailyDupPOD.amusementParkPOD then
				amusementParkPOD = dailyDupPOD
			end

			if dailyDupPOD.survivalPOD then
				survivalPOD = dailyDupPOD
			end

			if dailyDupPOD.horizontalRPGPOD ~= nil then
				horizontalRPGPOD = dailyDupPOD
			end

			if dailyDupPOD.fishingActivityPOD ~= nil then
				fishingActivityDupPOD = dailyDupPOD
			end
		end
	end

	ChallengeModule.ReloadChallengePOD(challengeDupPODList)
	ChallengeWorldBossModule.ReloadWorldBossPOD(worldBossDupPOD)
	ChallengeTowerModule.ReloadTowerPOD(towerDupPOD)
	RpgMazeModule.Reload(rpgMazePOD)
	PassCheckModule.ReloadPassPOD(passDupPOD)
	LunaBattleLineModule.Reload(lunaBattlePOD)
	DreamlandModule.Reload(dreamlandPOD)
	PlotChallengeModule.Reload(challengeDataPOD)
	DualTeamExploreModule.Reload(dualTeamExplorePOD)
	MagicTowerModule.Reload(magicTowerPOD)
	MonsterAcademyModule.Reload(miniGalGameDataPOD)
	EvilErosionModule.Reload(evilErosionPOD)
	EndlessPlusMazeModule.Reload(abyssPlusPOD)
	GuildChallengeModule.Reload(guildChallengePOD)
	MiningModule.Reload(miningDupPOD)
	SingleWeakTowerMould.Reload(singleWeakTower)
	FlightChallengeModule.Reload(flightChallengeDupPOD)
	GuildTrainingModule.Reload(guildTrainingPOD)
	RestaurantOperationModule.Reload(restaurantOperationPOD)
	PlaceGameModule.Reload(placeGamePOD)
	AmusementParkModule.Reload(amusementParkPOD)
	SurvivalModule.Reload(survivalPOD)
	HorizontalRPGModule.Reload(horizontalRPGPOD)
	FishingActivityModule.Reload(fishingActivityDupPOD)
end

function DailyDupModule.OpenChallengeUI(index, userData)
	UIModule.Close(Constant.UIControllerName.ExploreHallUI)
	UIModule.Close(Constant.UIControllerName.ChallengeDetailInfoUI)
	UIModule.Close(Constant.UIControllerName.ChallengeWorldBossDetailUI)
	UIModule.Close(Constant.UIControllerName.ChallengeTowerDetailUI)
	UIModule.Close(Constant.UIControllerName.MazeSelectLevelUI)
	UIModule.Open(Constant.UIControllerName.ExploreHallUI, Constant.UILayer.UI, {
		tabIndex = index,
		childTabIndex = userData
	})
end

function DailyDupModule.GetDailyDupPOD(cid)
	if DailyDupModule.DailyDupPODList then
		for i, dailyDupPOD in pairs(DailyDupModule.DailyDupPODList) do
			if dailyDupPOD.common.cid == cid then
				return dailyDupPOD
			end
		end
	end

	return nil
end

function DailyDupModule.IsOpenTime(cid)
	local dailyDupPod = DailyDupModule.GetDailyDupPOD(cid)

	if dailyDupPod == nil then
		return false
	end

	local isOpen = dailyDupPod.common.status == 1

	return isOpen
end

function DailyDupModule.IsFunctionOpen(cid)
	local cfgDailyDupData = CfgDailyDupTable[cid]
	local isOpen = UnlockFunctionModule.IsUnlock(cfgDailyDupData.OpenFunction)

	return isOpen
end

function DailyDupModule.GetLeftCount(dailyDupPOD)
	local cfgDailyDupData = CfgDailyDupTable[dailyDupPOD.common.cid]
	local cfgCount = cfgDailyDupData.Times

	return cfgCount + dailyDupPOD.buyCount - dailyDupPOD.enterCount, cfgCount
end

function DailyDupModule.BuyCount(dupCid)
	net_dailyDup.buyCount(dupCid)
end

function DailyDupModule.NotifyDailyDup(dailyDupPOD)
	local exist = false

	for i, oldDailyDupPOD in pairs(DailyDupModule.DailyDupPODList) do
		if oldDailyDupPOD.common.cid == dailyDupPOD.common.cid then
			exist = true
			DailyDupModule.DailyDupPODList[i] = dailyDupPOD

			break
		end
	end

	if not exist then
		table.insert(DailyDupModule.DailyDupPODList, dailyDupPOD)
	end

	if dailyDupPOD.challengePOD ~= nil then
		ChallengeModule.UpdateChallengeDupPOD(dailyDupPOD)
	end

	if dailyDupPOD.worldBossPOD ~= nil then
		ChallengeWorldBossModule.UpdateWorldBossDupPOD(dailyDupPOD)
	end

	if dailyDupPOD.towerPOD ~= nil then
		ChallengeTowerModule.UpdateTowerPOD(dailyDupPOD)
	end

	if dailyDupPOD.battlePassesPOD ~= nil then
		PassCheckModule.OnNotifyUpdate(dailyDupPOD)
	end

	if dailyDupPOD.rpgMazePOD ~= nil then
		RpgMazeModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.lunaBattleLineDataPOD ~= nil then
		LunaBattleLineModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.dreamMapPOD ~= nil then
		DreamlandModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.challengeDataPOD ~= nil then
		PlotChallengeModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.dualTeamExplorePOD ~= nil then
		DualTeamExploreModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.magicTowerPOD ~= nil then
		MagicTowerModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.miniGalGameDataPOD ~= nil then
		MonsterAcademyModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.evilErosionPOD ~= nil then
		EvilErosionModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.abyssPlusPOD ~= nil then
		EndlessPlusMazeModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.guildChallengePOD ~= nil then
		GuildChallengeModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.miningPOD ~= nil then
		MiningModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.singleWeakTower ~= nil or dailyDupPOD.common.cid == 20 and dailyDupPOD.common.status == 1 then
		SingleWeakTowerMould.Update(dailyDupPOD)
	end

	if dailyDupPOD.flightChallengePOD ~= nil then
		FlightChallengeModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.guildTrainingPOD then
		GuildTrainingModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.restaurantOperationPOD then
		RestaurantOperationModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.placeGamePOD then
		PlaceGameModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.amusementParkPOD then
		AmusementParkModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.survivalPOD then
		SurvivalModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.horizontalRPGPOD then
		HorizontalRPGModule.Update(dailyDupPOD)
	end

	if dailyDupPOD.fishingActivityPOD then
		FishingActivityModule.Update(dailyDupPOD)
	end

	EventDispatcher.Dispatch(EventID.UpdateDailyDupEvent)
end

function DailyDupModule.Shutdown()
	LunaBattleLineModule.Shutdown()
	DreamlandModule.Shutdown()
	PlotChallengeModule.Shutdown()
	DualTeamExploreModule.Shutdown()
	MagicTowerModule.Shutdown()
	MonsterAcademyModule.Shutdown()
	EvilErosionModule.Shutdown()
	EndlessPlusMazeModule.Shutdown()
	GuildChallengeModule.Shutdown()
	MiningModule.Shutdown()
	SingleWeakTowerMould.Shutdown()
	FlightChallengeModule.Shutdown()
	GuildTrainingModule.Shutdown()
	RestaurantOperationModule.Shutdown()
	PlaceGameModule.Shutdown()
	AmusementParkModule.Shutdown()
	SurvivalModule.Shutdown()
	HorizontalRPGModule.Shutdown()
	FishingActivityModule.Shutdown()
end
