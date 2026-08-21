-- chunkname: @IQIGame\\Net\\NetSoulPrefabResponse.lua

function net_soulPrefab.wearEquipmentResult(code)
	EquipModule.OnReqPutOnResult()
end

function net_soulPrefab.dumpEquipmentResult(code)
	EquipModule.OnReqTakeOffResult()
end

function net_soulPrefab.upgradeEquipmentResult(code)
	EquipModule.OnReqUpEquipResult()
end

function net_soulPrefab.upStarEquipmentResult(code)
	EquipModule.OnReqBreakEquipResult()
end

function net_soulPrefab.changeSoulPrefabDataResult(code)
	SoulPrefabModule.OnReqChangeSoulPrefabData()
end

function net_soulPrefab.acceptPrefabQuestResult(code)
	SoulPrefabModule.OnReqAcceptPrefabQuest()
end

function net_soulPrefab.giveupPrefabQuestResult(code)
	SoulPrefabModule.OnReqGiveUpPrefabQuest()
end

function net_soulPrefab.notifySoulPrefab(pods)
	SoulPrefabModule.OnNotifySoulPrefab(pods)
end

function net_soulPrefab.decpEquipmentResult(code, items)
	SoulPrefabModule.OnReqDecomposeResult(items)
end

function net_soulPrefab.activationPrefabResult(code)
	SoulPrefabModule.OnReqActivePrefab()
end

function net_soulPrefab.changeSoulPrefabResult(code)
	FormationModule.ChooseSoulComplete()
end

function net_soulPrefab.changeFormationPosResult(code)
	return
end

function net_soulPrefab.coverEquipmentsResult(code)
	EquipModule.OnReqCoverEquipmentsResult()
end

function net_soulPrefab.exchangeEquipmentResult(code)
	EquipModule.OnReqExchangeEquipmentResult()
end

function net_soulPrefab.saveEquipmentPrefabResult(code)
	return
end

function net_soulPrefab.notifyEquipmentPrefabChange(pod)
	PlayerModule.UpdateEquipmentPrefab(pod)
end

function net_soulPrefab.changEquipmentPrefabNameResult(code)
	return
end
