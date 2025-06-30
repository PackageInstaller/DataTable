-- chunkname: @IQIGame\\Net\\NetPlaceGameResponse.lua

function net_placeGame.recruitResult(code, placeGameSoulPOD, firingSoulPODs)
	PlaceGameModule.RecruitResult(placeGameSoulPOD, firingSoulPODs)
end

function net_placeGame.levelUpResult(code, placeGameSoulPOD)
	PlaceGameModule.LevelUpResult(placeGameSoulPOD)
end

function net_placeGame.dismissalResult(code, id, firingSoulPODs)
	PlaceGameModule.DismissalResult(id, firingSoulPODs)
end

function net_placeGame.changeFormationNameResult(code, id, name)
	PlaceGameModule.ChangeFormationNameResult(id, name)
end

function net_placeGame.goIntoBattleResult(code, formation)
	PlaceGameModule.GoIntoBattleResult(formation)
end

function net_placeGame.modifySoulResult(code, placeGameSoulPrefabPOD)
	PlaceGameModule.ModifySoulResult(placeGameSoulPrefabPOD)
end

function net_placeGame.changePositionResult(code, position)
	PlaceGameModule.ChangePositionResult(position)
end

function net_placeGame.modifyWeaponResult(code, placeSoulPrefabPODs)
	PlaceGameModule.ModifyWeaponResult(placeSoulPrefabPODs)
end

function net_placeGame.climbingTowerResult(code)
	PlaceGameModule.ClimbingTowerResult()
end

function net_placeGame.openTheBoxResult(code, items)
	PlaceGameModule.OpenTheBoxResult(items)
end

function net_placeGame.buyATreasureChestResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 54010 then
			NoticeModule.ShowNotice(21045110)

			return
		end

		NoticeModule.ShowServerError(code)

		return
	end

	net_placeGame.buyATreasureChestResult(code, items)
end

function net_placeGame.buyATreasureChestResult(code, items)
	PlaceGameModule.BuyATreasureChestResult(items)
end

function net_placeGame.allSoulUnloadResult(code, placeSoulPrefabPODs)
	PlaceGameModule.AllSoulUnloadResult(placeSoulPrefabPODs)
end

function net_placeGame.allEquipUnloadResult(code, placeSoulPrefabPODs)
	PlaceGameModule.AllEquipUnloadResult(placeSoulPrefabPODs)
end

function net_placeGame.soulEquipUnloadResult(code, placeGameSoulPrefabPOD)
	PlaceGameModule.SoulEquipUnloadResult(placeGameSoulPrefabPOD)
end

function net_placeGame.openDialogResult(code, dialogCid)
	PlaceGameModule.OpenDialogResult(dialogCid)
end

function net_placeGame.selectDialogResult(code, nextDialogCid, items)
	PlaceGameModule.SelectDialogResult(nextDialogCid, items)
end

function net_placeGame.equipmentLockResult(code)
	PlaceGameModule.EquipmentLockResult()
end

function net_placeGame.equipmentResolveResult(code, items)
	PlaceGameModule.EquipmentResolveResult(items)
end

function net_placeGame.notifyBoss(win, cid, dmgRecords, items)
	PlaceGameModule.NotifyBoss(win, cid, dmgRecords, items)
end

function net_placeGame.notifyFormation(placeGameSoulPrefabPOD)
	PlaceGameModule.NotifyFormation(placeGameSoulPrefabPOD)
end

function net_placeGame.notifyEventIsFinish(eventId)
	PlaceGameModule.NotifyEventIsFinish(eventId)
end

function net_placeGame.notifyBoxAdd(num)
	PlaceGameModule.NotifyBoxAdd(num)
end

function net_placeGame.notifyChallengeLevel(cid)
	PlaceGameModule.NotifyChallengeLevel(cid)
end
