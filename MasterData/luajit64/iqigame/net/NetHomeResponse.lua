-- chunkname: @IQIGame\\Net\\NetHomeResponse.lua

function net_home.enterHomeResult(code, home)
	HomeLandLuaModule.EnterHomeResult(home, false)
end

function net_home.harvestBuildingResult(code, building, itemAwards)
	HomeLandLuaModule.HarvestBuildingResult(building, itemAwards)
end

function net_home.harvestLandResult(code, buildingCid, land, itemAwards)
	HomeLandLuaModule.HarvestLandResult(buildingCid, land, itemAwards)
end

function net_home.manufactureResult(code, getItems)
	return
end

function net_home.plantResult(code, buildingCid, land)
	HomeLandLuaModule.PlantResult(buildingCid, land)
end

function net_home.notifyUpdateBasicHome(basicHome)
	HomeLandLuaModule.NotifyUpdateBasicHome(basicHome)
end

function net_home.notifyUpdateLand(buildingCid, land)
	HomeLandLuaModule.NotifyUpdateLand(buildingCid, land)
end

function net_home.notifyUpdateBuilding(building)
	HomeLandLuaModule.NotifyUpdateBuilding(building)
end

function net_home.notifyUpdateRoom(room)
	HomeLandLuaModule.NotifyUpdateRoom(room)
end

function net_home.notifyUnlockManufactureItem(manufactureItemCid)
	HomeLandLuaModule.NotifyUnlockManufactureItem(manufactureItemCid)
end

function net_home.notifyActivationDecorates(activationDecorates)
	FurnitureLotteryModule.NotifyActivationDecorates(activationDecorates)
end

function net_home.unlockRoomResult(code, cid)
	HomeLandLuaModule.UnlockRoomResult(cid)
end

function net_home.changeSuitResult(code, room)
	HomeLandLuaModule.ChangeSuitResult(room)
end

function net_home.unlockSuitResult(code, suitCid)
	HomeLandLuaModule.UnlockSuitResult(suitCid)
end

function net_home.visitHomeResult(code, targetPid, home)
	HomeLandLuaModule.VisitHomeResult(targetPid, home)
end

function net_home.visitHomeResult_delegate(code, targetPid, home)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 11024 then
			NoticeModule.ShowNotice(21040125)
		else
			NoticeModule.ShowServerError(code)
		end

		return
	end

	net_home.visitHomeResult(code, targetPid, home)
end

function net_home.cookResult(code, building)
	HomeLandLuaModule.CookResult(building)
end

function net_home.completeCookResult(code, building)
	HomeLandLuaModule.CompleteCookResult(building)
end

function net_home.cancelCookResult(code, building)
	HomeLandLuaModule.CancelCookResult(building)
end

function net_home.rewardCookResult(code, building, itemAwards, cookBookIds)
	HomeLandLuaModule.RewardCookResult(building, itemAwards, cookBookIds)
end

function net_home.getCookBookRewardsResult(code, cid, itemShows)
	HomeLandLuaModule.GetCookBookRewardsResult(cid, itemShows)
end

function net_home.notifyUnlockCookBook(cookBookId)
	HomeLandLuaModule.NotifyUnlockCookBook(cookBookId)
end

function net_home.changeRoomNameResult(code, room)
	HomeLandLuaModule.ChangeRoomNameResult(room)
end

function net_home.enterRoomResult(code, room)
	HomeLandLuaModule.EnterRoomResult(room)
end

function net_home.switchRoomShowResult(code, room)
	HomeLandLuaModule.SwitchRoomShowResult(room)
end

function net_home.notifyHomeRole(roles)
	HomeLandLuaModule.NotifyHomeRole(roles)
end

function net_home.receiveComfortLvAwardsResult(code, itemAwards)
	HomeLandLuaModule.ReceiveComfortLvAwardsResult(itemAwards)
end

function net_home.startWorkResult(code, building, count)
	HLWorkModule.OnReqStartWorkResult(building, count)
end

function net_home.undoAffairResult(code)
	HLWorkModule.OnReqGiveUpWorkResult()
end

function net_home.rewardWorkResult(code, building, rewardPODs)
	HLWorkModule.OnReqGetRewardResult(building, rewardPODs)
end

function net_home.completePlantResult(code, buildingCid, land)
	HomeLandLuaModule.CompletePlantResult(buildingCid, land)
end

function net_home.cancelPlantResult(code, buildingCid, land)
	HomeLandLuaModule.CancelPlantResult(buildingCid, land)
end

function net_home.makeResult(code, building)
	HomeLandManufactureMould.MakeResult(building)
end

function net_home.cancelMakeResult(code, building)
	HomeLandManufactureMould.CancelMakeResult(building)
end

function net_home.rewardMakeResult(code, building, itemAward)
	HomeLandManufactureMould.RewardMakeResult(building, itemAward)
end

function net_home.completeMakeResult(code, building)
	HomeLandManufactureMould.CompleteMakeResult(building)
end

function net_home.completeMakeResult_delegate(code, building)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 25026 then
			NoticeModule.ShowNotice(21040124)
		else
			NoticeModule.ShowServerError(code)
		end

		return
	end

	net_home.completeMakeResult(code, building)
end

function net_home.helpResult(code, id, itemShows)
	HomeLandVisitMould.HelpResult(id, itemShows)
end

function net_home.openVisitTreasureChestResult(code, boxId, itemShows)
	HomeLandVisitMould.OpenVisitTreasureChestResult(boxId, itemShows)
end

function net_home.receiveComfortAwardsResult(code, roomId, itemShows)
	HomeLandLuaModule.ReceiveComfortAwardsResult(roomId, itemShows)
end

function net_home.saveRoomDecorateResult(code, roomId)
	HomeLandLuaModule.SaveRoomDecorateResult(roomId)
end

function net_home.receiveLetterResult(code, roleCid, letterCid, getItems)
	HomeLandLuaModule.ReceiveLetterResult(roleCid, letterCid, getItems)
end

function net_home.updateBuildingLvResult(code)
	HomeLandLuaModule.UpdateBuildingLvResult(code)
end

function net_home.compoundResult(code, getItems)
	HomeLandProcessMould.CompoundResult(getItems)
end

function net_home.decomposeResult(code, getItems)
	HomeLandProcessMould.DecomposeResult(getItems)
end

function net_home.resetAffairResult()
	HLWorkModule.OnReqRefreshAffair()
end

function net_home.notifyUnlockSuit(ids)
	HomeLandLuaModule.NotifyUnlockSuit(ids)
end

function net_home.exitHomeResult(code)
	HomeLandLuaModule.ExitHomeResult()
end

function net_home.recordDailyActionResult(code)
	HomeLandLuaModule.RecordDailyActionResult()
end

function net_home.decomposeDecorateResult(code, decorateCid, num)
	HomeLandLuaModule.DecomposeDecorateResult(decorateCid, num)
end

function net_home.unlockLandResult(code, landPOD)
	HomeLandLuaModule.UnlockLandResult(landPOD)
end
