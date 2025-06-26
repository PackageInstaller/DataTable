-- chunkname: @IQIGame\\Module\\Formation\\FormationModule.lua

FormationModule = {}

function FormationModule.SendExchangePrefab(formationId, nowPrefabIndex, prevPrefabIndex, nowSkillGroupCid, nowCustomSkills)
	net_formation.exchangeSoulPrefab(formationId, nowPrefabIndex, prevPrefabIndex, nowSkillGroupCid, nowCustomSkills)
end

function FormationModule.SendChangeName(formationId, name)
	net_formation.changeFormationName(formationId, name)
end

function FormationModule.SendCopyFormation(srcFormationId, targetFormationId)
	net_formation.copyFormation(srcFormationId, targetFormationId)
end

function FormationModule.OnChangeNameResponse(name)
	if string.match(name, "*") then
		NoticeModule.ShowNotice(21046001)
	end
end

function FormationModule.ChooseSoulComplete()
	EventDispatcher.Dispatch(EventID.FormationChooseSoulComplete)
end

function FormationModule.OnCopyFormation(fromId, copyToId)
	return
end

function FormationModule.GetFormationPowerByIndex(formationIndex)
	local targetFormationPOD

	for i = 1, #PlayerModule.PlayerInfo.formations do
		local formationPOD = PlayerModule.PlayerInfo.formations[i]

		if formationPOD.index == formationIndex then
			targetFormationPOD = formationPOD

			break
		end
	end

	if targetFormationPOD == nil then
		return 0
	end

	local power = 0

	for soulPrefabId, pos in pairs(targetFormationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(soulPrefabId)

		power = power + soulPrefabData.power
	end

	return power
end

function FormationModule.GetFormationByIndex(index)
	for i = 1, #PlayerModule.PlayerInfo.formations do
		local pod = PlayerModule.PlayerInfo.formations[i]

		if pod ~= nil and pod.index == index then
			return pod
		end
	end

	local errLogIndexes = {}

	for i, pod in pairs(PlayerModule.PlayerInfo.formations) do
		table.insert(errLogIndexes, pod.index)
	end

	logError("在Player身上找不到对应的formationPOD, index .. " .. tostring(index) .. "，已有的formation index：" .. tableToString(errLogIndexes))

	return nil
end

function FormationModule.CheckEquipIsOnBySamplePrefab(itemData, samplePrefabId, excludedPrefabId)
	if itemData == nil then
		logError("itemData参数错误: itemData is nil ")

		return false, nil
	end

	if itemData.equipData == nil then
		logError("itemData参数错误: 不是装备数据")

		return false, nil
	end

	if not itemData.equipData.isWore then
		return false, nil
	end

	local targetFormationPOD

	for i = 1, #PlayerModule.PlayerInfo.formations do
		local formationPOD = PlayerModule.PlayerInfo.formations[i]

		for prefabId, prefabIndex in pairs(formationPOD.formation) do
			if prefabId == samplePrefabId then
				targetFormationPOD = formationPOD

				break
			end
		end

		if targetFormationPOD ~= nil then
			break
		end
	end

	return FormationModule.CheckEquipIsOn(itemData, targetFormationPOD, excludedPrefabId)
end

function FormationModule.CheckEquipIsOn(itemData, formationPOD, excludedPrefabId)
	if itemData == nil then
		logError("itemData参数错误: itemData is nil ")

		return
	end

	if itemData.equipData == nil then
		logError("itemData参数错误: 不是装备数据")

		return
	end

	if not itemData.equipData.isWore then
		return false, nil
	end

	local isOn = false
	local hostId

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		if prefabId ~= excludedPrefabId then
			local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

			for i, itemDataOnPrefab in pairs(soulPrefabData.equipItemDatum) do
				if itemData.id == itemDataOnPrefab.id then
					isOn = true
					hostId = prefabId

					break
				end
			end

			if isOn then
				break
			end
		end
	end

	return isOn, hostId
end

function FormationModule.GetSoulIndexInFormation(soulData, formationIndex)
	local formationPOD = FormationModule.GetFormationByIndex(formationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if soulPrefabData.soulCid == soulData.soulCid then
			return prefabIndex
		end
	end

	return -1
end

function FormationModule.ChangeEquip(prefabId, toReplaceEquipIndex, equipData, onConfirmed)
	local needConfirm = false
	local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)
	local toReplaceEquipData = soulPrefabData.equipItemDatum[toReplaceEquipIndex]
	local isSelected = toReplaceEquipData ~= nil and equipData.id == toReplaceEquipData.id

	if isSelected then
		EquipModule.ReqTakeOff({
			prefabId
		}, equipData.id)
	else
		local equipIndexOnOtherSlot = -1
		local wearingSameNameEquipId

		for i, itemData in pairs(soulPrefabData.equipItemDatum) do
			if itemData.id == equipData.id then
				equipIndexOnOtherSlot = i
			end

			if itemData.cid == equipData.cid then
				wearingSameNameEquipId = itemData.id
			end
		end

		if equipIndexOnOtherSlot ~= -1 then
			EquipModule.ReqExchangeEquipment(prefabId, toReplaceEquipIndex, equipIndexOnOtherSlot)
		else
			local isOnOtherPrefabInSameTeam, equipHostPrefabId = FormationModule.CheckEquipIsOnBySamplePrefab(equipData, prefabId, prefabId)

			needConfirm = isOnOtherPrefabInSameTeam or wearingSameNameEquipId ~= nil

			local noticeCid

			if isOnOtherPrefabInSameTeam and wearingSameNameEquipId == nil then
				noticeCid = 21053008
			elseif not isOnOtherPrefabInSameTeam and wearingSameNameEquipId ~= nil then
				noticeCid = 21053009
			elseif isOnOtherPrefabInSameTeam and wearingSameNameEquipId ~= nil then
				noticeCid = 21053010
			else
				EquipModule.ReqPutOn(prefabId, equipData.id, toReplaceEquipIndex)
			end

			if needConfirm then
				NoticeModule.ShowNotice(noticeCid, function()
					if wearingSameNameEquipId ~= nil then
						EquipModule.ReqTakeOff({
							prefabId
						}, wearingSameNameEquipId)
					end

					EquipModule.ReqPutOn(prefabId, equipData.id, toReplaceEquipIndex)

					if onConfirmed ~= nil then
						onConfirmed()
					end
				end, nil)
			end
		end
	end

	return needConfirm
end

function FormationModule.GetLastChooseFormationId()
	local lastChooseFormationIndex = 1
	local playerPrefTabIndex = PlayerPrefsUtil.GetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.FormationTeamIndex, 0)

	if playerPrefTabIndex > 0 and playerPrefTabIndex <= #PlayerModule.PlayerInfo.formations then
		lastChooseFormationIndex = playerPrefTabIndex
	end

	return lastChooseFormationIndex
end

function FormationModule.CopyTo(srcIndex, targetIndex)
	local srcFormationPOD = FormationModule.GetFormationByIndex(srcIndex)
	local targetFormationPOD = FormationModule.GetFormationByIndex(targetIndex)

	FormationModule.SendCopyFormation(srcFormationPOD.id, targetFormationPOD.id)
end
