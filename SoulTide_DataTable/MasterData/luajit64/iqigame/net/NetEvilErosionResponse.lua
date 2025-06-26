-- chunkname: @IQIGame\\Net\\NetEvilErosionResponse.lua

function net_evilErosion.changeCustomSkillsResult(code)
	EvilErosionModule.OnCustomSkillChanged()
end

function net_evilErosion.changePositionResult(code)
	EvilErosionModule.OnPositionChanged()
end

function net_evilErosion.changeFormationPosResult(code)
	EvilErosionModule.OnFormationPosChanged()
end

function net_evilErosion.notifyUpdateSoulPrefab(pods)
	EvilErosionModule.OnSoulPrefabChanged(pods)
end

function net_evilErosion.wearEquipmentResult(code)
	EvilErosionModule.OnWearingEquipChanged()
end

function net_evilErosion.dumpEquipmentResult(code)
	EvilErosionModule.OnWearingEquipChanged()
end

function net_evilErosion.exchangeEquipmentResult(code)
	EvilErosionModule.OnWearingEquipChanged()
end

function net_evilErosion.decpEquipmentResult(code, getItems)
	EvilErosionModule.OnDecomposeEquipComplete(getItems)
end

function net_evilErosion.upStarEquipmentResult(code)
	EvilErosionModule.OnUpgradeEquipComplete()
end

function net_evilErosion.getDailySupplyResult(code, getItems)
	EvilErosionModule.OnGetDailySupply(getItems)
end

function net_evilErosion.fightResult(code)
	EvilErosionModule.OnFight()
end

function net_evilErosion.notifyFightComplete(win, levelCid, dmgRecords, getItems, rating, ratingTime)
	EvilErosionModule.OnFightComplete(win, levelCid, dmgRecords, getItems, rating, ratingTime)
end
