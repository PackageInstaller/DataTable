-- chunkname: @IQIGame\\Module\\SoulPrefab\\SoulPrefabModule.lua

SoulPrefabModule = {
	soul2PrefabsDic = {}
}

function SoulPrefabModule.Reload(soulPrefabs)
	SoulPrefabModule.soul2PrefabsDic = {}

	table.sort(soulPrefabs, function(a, b)
		return a.id < b.id
	end)

	for i = 1, #soulPrefabs do
		local soulPrefabPOD = soulPrefabs[i]
		local data = SoulPrefabData.New()

		data:Initialize(soulPrefabPOD)

		SoulPrefabModule.soul2PrefabsDic[soulPrefabPOD.id] = data
	end
end

function SoulPrefabModule.GetPrefabByEquipId(equipId)
	local prefabs = {}

	for id, soulPrefabData in pairs(SoulPrefabModule.soul2PrefabsDic) do
		for m, n in pairs(soulPrefabData.equipItemDatum) do
			if n.id == equipId then
				table.insert(prefabs, soulPrefabData)
			end
		end
	end

	return prefabs
end

function SoulPrefabModule.GetPrefab(id)
	return SoulPrefabModule.soul2PrefabsDic[id]
end

function SoulPrefabModule.GetPrefabs(soulCid)
	return {}
end

function SoulPrefabModule.CheckPrefabIsUnlock(prefabCid)
	return false
end

function SoulPrefabModule.CheckGroupIsUnlock(soulData, groupIndex)
	local id = CfgSoulTable[soulData.soulCid].DefaultSkill[groupIndex]

	for i, v in pairs(soulData.unlockSkillGroups) do
		if v == id then
			return true
		end
	end

	return false
end

function SoulPrefabModule.CheckUnlockLvOk(prefabData)
	local soulData = SoulModule.soulDataDic[prefabData.soulCid]

	return soulData.lv >= prefabData.cfgPrefabData.UnlockLv
end

function SoulPrefabModule.CheckUnlockItemOk(prefabData)
	for i, v in ipairs(prefabData.cfgPrefabData.UnlockCost) do
		if i % 2 ~= 0 and WarehouseModule.GetItemNumByCfgID(v) < prefabData.cfgPrefabData.UnlockCost[i + 1] then
			return false
		end
	end

	return true
end

function SoulPrefabModule.CheckPrePrefabIsUnlock(prefabData)
	if prefabData.index == 1 then
		return true
	end

	local datum = SoulPrefabModule.GetPrefabs(prefabData.soulCid)

	return datum[prefabData.index - 1].isUnlock
end

function SoulPrefabModule.CheckPrefabCanUnlock(prefabData)
	return false
end

function SoulPrefabModule.CheckExistPrefabCanUnlock(soulCid)
	local prefabs = SoulPrefabModule.GetPrefabs(soulCid)

	for i, v in pairs(prefabs) do
		if SoulPrefabModule.CheckPrefabCanUnlock(v) then
			return true
		end
	end

	return false
end

function SoulPrefabModule.CheckWoreSpecialEquip(soulCid)
	return false
end

function SoulPrefabModule.ChangeEquipPrefabName(equipPrefabId, name)
	net_soulPrefab.changEquipmentPrefabName(equipPrefabId, name)
end

function SoulPrefabModule.GetJewelryAndSpeed(soulPrefabData)
	if soulPrefabData == nil then
		return nil, 0
	end

	local itemID
	local speed = 0

	if soulPrefabData ~= nil then
		itemID, speed = soulPrefabData:GetEquipJewelryAndSpeed()
	end

	return itemID, speed
end

function SoulPrefabModule.ReqActivePrefab(soulCid, prefabCid)
	SoulPrefabModule.lastHandlePrefabCid = prefabCid

	net_soulPrefab.activationPrefab(soulCid, prefabCid)
end

function SoulPrefabModule.OnReqActivePrefab()
	return
end

function SoulPrefabModule.ReqAcceptPrefabQuest(prefabCid)
	net_soulPrefab.acceptPrefabQuest(prefabCid)
end

function SoulPrefabModule.OnReqAcceptPrefabQuest()
	EventDispatcher.Dispatch(EventID.SoulPrefabQuestAcceptSuccess)
end

function SoulPrefabModule.ReqGiveUpPrefabQuest(prefabCid)
	net_soulPrefab.giveupPrefabQuest(prefabCid)
end

function SoulPrefabModule.OnReqGiveUpPrefabQuest()
	EventDispatcher.Dispatch(EventID.SoulPrefabQuestGiveUpSuccess)
end

function SoulPrefabModule.ReqChangeSoulPrefabData(soulPrefabId, skillCIds, groupType, soulClass)
	net_soulPrefab.changeSoulPrefabData(soulPrefabId, skillCIds, groupType, soulClass)
end

function SoulPrefabModule.OnReqChangeSoulPrefabData()
	EventDispatcher.Dispatch(EventID.SoulPrefabSkillSaveSuccess)
	NoticeModule.ShowNotice(21041020)
end

function SoulPrefabModule.OnNotifySoulPrefab(pods)
	for i, soulPrefabPOD in ipairs(pods) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(soulPrefabPOD.id)

		soulPrefabData:Update(soulPrefabPOD)
	end

	EventDispatcher.Dispatch(EventID.SoulPrefabUpdate)
end

function SoulPrefabModule.ReqDecompose(ids, isReset)
	SoulPrefabModule.isRecast = isReset

	net_soulPrefab.decpEquipment(ids, isReset)
end

function SoulPrefabModule.OnReqDecomposeResult(items)
	if #items > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	end

	EventDispatcher.Dispatch(EventID.EquipDecomposeSuccess, SoulPrefabModule.isRecast)
end

function SoulPrefabModule.SendChangeSoulPrefab(prefabId, soulCid, skillGroupCid, customSkills, optionalSkill)
	net_soulPrefab.changeSoulPrefab(prefabId, soulCid, skillGroupCid, customSkills, optionalSkill)
end

function SoulPrefabModule.SendChangeSoulPosition(prefabId, pos)
	net_soulPrefab.changeFormationPos(prefabId, pos)
end

function SoulPrefabModule.SendSetJewelrySpeed(prefabId, jewelryCid, speed)
	net_soulPrefab.setJewelrySpeed(prefabId, jewelryCid, speed)
end
