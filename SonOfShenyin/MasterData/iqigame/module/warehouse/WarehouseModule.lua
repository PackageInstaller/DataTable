-- chunkname: @IQIGame\\Module\\Warehouse\\WarehouseModule.lua

WarehouseModule = {}
WarehouseModule.AllItems = {}
WarehouseModule.SelectAllItems = {}
WarehouseModule.ConverterItems = {}

function WarehouseModule.Reload(items)
	WarehouseModule.AllItems = {}

	local index = 0

	for i, v in pairs(items) do
		if v.num > 0 then
			index = index + 1
			WarehouseModule.AllItems[index] = ItemData.New(v)
		end
	end

	WarehouseModule.SetWarehouseItemCount()
end

function WarehouseModule.UpdateData(itemPOD)
	local itemInWarehouse, indexInWarehouse

	itemInWarehouse, indexInWarehouse = WarehouseModule.FindItem(itemPOD.id)

	itemInWarehouse:Update(itemPOD)

	WarehouseModule.AllItems[indexInWarehouse] = itemInWarehouse

	return itemInWarehouse
end

function WarehouseModule.Update(items)
	local itemInWarehouse, indexInWarehouse, itemFromServer
	local addItems = {}
	local deleteItems = {}
	local updateItems = {}

	for i = 1, #items do
		itemFromServer = items[i]
		itemInWarehouse, indexInWarehouse = WarehouseModule.FindItem(itemFromServer.id)

		if itemInWarehouse == nil then
			itemInWarehouse = ItemData.New(itemFromServer)

			table.insert(addItems, itemInWarehouse)
		elseif itemFromServer.num == nil or itemFromServer.num == 0 then
			table.insert(deleteItems, itemInWarehouse)
		else
			itemInWarehouse:Update(itemFromServer)

			WarehouseModule.AllItems[indexInWarehouse] = itemInWarehouse
		end

		table.insert(updateItems, itemInWarehouse)
	end

	for i = 1, #deleteItems do
		for j = #WarehouseModule.AllItems, 1, -1 do
			if WarehouseModule.AllItems[j].id == deleteItems[i].id then
				table.remove(WarehouseModule.AllItems, j)
			end
		end
	end

	for i = 1, #addItems do
		table.insert(WarehouseModule.AllItems, addItems[i])
	end

	log("仓库更新，总共更新了" .. #items .. "个物品。删除" .. #deleteItems .. "个，增加" .. #addItems .. "个，目前总共有" .. #WarehouseModule.AllItems .. "个物品")

	if #addItems > 0 then
		EventDispatcher.Dispatch(EventID.AddItem, addItems)
	end

	if #deleteItems > 0 then
		EventDispatcher.Dispatch(EventID.DeleteItem, deleteItems)
	end

	if #updateItems > 0 then
		EventDispatcher.Dispatch(EventID.UpdateItem, updateItems)
	end

	WarehouseModule.SetWarehouseItemCount()
end

function WarehouseModule.GetAllItemCount()
	local items = {}

	for k, v in pairs(WarehouseModule.AllItems) do
		if v:GetCfg().Reveal == true and table.indexOf(items, v.id) == -1 then
			table.insert(items, v)
		end
	end

	return #items
end

function WarehouseModule.FindItem(itemInstanceID)
	for i = 1, #WarehouseModule.AllItems do
		if WarehouseModule.AllItems[i].id == itemInstanceID then
			return WarehouseModule.AllItems[i], i
		end
	end

	return nil, -1
end

function WarehouseModule.FindItemForCid(itemInstanceID)
	for i = 1, #WarehouseModule.AllItems do
		if WarehouseModule.AllItems[i].cid == itemInstanceID then
			return WarehouseModule.AllItems[i], i
		end
	end

	return nil, -1
end

function WarehouseModule.GetAllItemsByCid(cid)
	local items = {}

	for i = 1, #WarehouseModule.AllItems do
		if WarehouseModule.AllItems[i].cid == cid then
			table.insert(items, WarehouseModule.AllItems[i])
		end
	end

	return items
end

function WarehouseModule.GetItemNumByCfgID(cfgID)
	local num = 0

	for i = 1, #WarehouseModule.AllItems do
		if WarehouseModule.AllItems[i].cid == cfgID then
			num = num + WarehouseModule.AllItems[i].num
		end
	end

	return num
end

function WarehouseModule.GetItemNumByid(id)
	local num = 0

	for i = 1, #WarehouseModule.AllItems do
		if WarehouseModule.AllItems[i].id == id then
			num = num + WarehouseModule.AllItems[i].num

			break
		end
	end

	return num
end

function WarehouseModule.DoesItExistItem(comparison, cid, compareKey)
	if comparison == "==" then
		for i, v in pairs(WarehouseModule.AllItems) do
			if v.cid == cid then
				return true
			end
		end

		return false
	elseif comparison == "!=" then
		for i, v in pairs(WarehouseModule.AllItems) do
			if compareKey then
				if i == cid then
					return false
				end
			elseif v.cid == cid then
				return false
			end
		end

		return true
	end
end

function WarehouseModule.GetEnoughItemsByNum(cid, num)
	local allItems = WarehouseModule.GetAllItemsByCid(cid)
	local items = {}
	local surplusNum = num

	for i = 1, #allItems do
		if surplusNum > allItems[i].num then
			items[allItems[i].id] = allItems[i].num
			surplusNum = num - allItems[i].num
		else
			items[allItems[i].id] = surplusNum

			return items
		end
	end

	return items
end

function WarehouseModule.SetWarehouseItemCount()
	WarehouseModule.curAllItemCount = 0

	for k, v in pairs(WarehouseModule.AllItems) do
		if v:GetCfg().Reveal then
			WarehouseModule.curAllItemCount = WarehouseModule.curAllItemCount + 1
		end
	end

	EventDispatcher.Dispatch(EventID.RefreshShowItemCount)
end

function WarehouseModule.GetAllItemsByTabType(tabType)
	local items = {}
	local itemData, cfgItemData

	for i = 1, #WarehouseModule.AllItems do
		itemData = WarehouseModule.AllItems[i]
		cfgItemData = itemData:GetCfg()

		if cfgItemData ~= nil and cfgItemData.DepotType == tabType then
			table.insert(items, itemData)
		end
	end

	WarehouseModule.SelectAllItems = items

	return items
end

function WarehouseModule.GetAllItemsByTypeAndSubType(itemTypes, itemSubTypes)
	local items = {}
	local itemConfig

	for _, itemData in pairs(WarehouseModule.AllItems) do
		itemConfig = itemData:GetCfg()

		if itemConfig.ItemTypes == itemTypes then
			if itemSubTypes ~= nil then
				if itemConfig.ItemSubTypes == itemSubTypes then
					table.insert(items, itemData)
				end
			else
				table.insert(items, itemData)
			end
		end
	end

	return items
end

function WarehouseModule.GetItemDataById(id)
	for i, v in pairs(WarehouseModule.AllItems) do
		if v.id == id then
			return v
		end
	end

	return nil
end

function WarehouseModule.GetItemDataBySkillId(id)
	for i, v in pairs(WarehouseModule.AllItems) do
		if v.skillData and v.skillData.id == id then
			return v
		end
	end
end

function WarehouseModule.GetItemDataByTypes(types)
	local items = {}

	for k, v in pairsCfg(CfgItemTable) do
		if table.indexOf(types, v.ItemTypes) ~= -1 then
			table.insert(items, v)
		end
	end

	return items
end

function WarehouseModule.GetWarehouseItemWithType(type)
	local items = {}

	for _, v in pairsCfg(WarehouseModule.AllItems) do
		if v:GetCfg().ItemTypes == type then
			table.insert(items, v)
		end
	end

	return items
end

function WarehouseModule.CheckCanUse(itemData, useNum)
	local cfgItemData = itemData:GetCfg()
	local startTime = itemData:ConversionTime(cfgItemData.StartTime)
	local expirationTime = itemData:ConversionTime(cfgItemData.ExpirationTime)

	if itemData:GetCD() > 0 then
		return false, WarehouseUIApi:GetNoticeUseCDText()
	end

	if startTime > PlayerModule.GetServerTime() then
		return false, WarehouseUIApi:GetNoticeUseNotActiveText()
	end

	if expirationTime ~= 0 and expirationTime < PlayerModule.GetServerTime() then
		return false, WarehouseUIApi:GetNoticeExpiredText()
	end

	local checkConsumeSucceed, errorMessage = WarehouseModule.CheckConsume(cfgItemData, useNum)

	if not checkConsumeSucceed then
		return checkConsumeSucceed, errorMessage
	end

	return true, nil
end

function WarehouseModule.CheckConsume(cfgItemData, useNum)
	return true, nil
end

function WarehouseModule.CheckIsItemFragment(cfgItemData)
	local itemType = cfgItemData.ItemTypes
	local itemSubType = cfgItemData.ItemSubTypes

	if itemType == Constant.ItemType.HeroDebris then
		for k, v in pairs(Constant.ItemSubType[itemType]) do
			if itemSubType == v then
				return true
			end
		end
	end

	return false
end

function WarehouseModule.GetItemDataByCfgID(cfgID)
	for i = 1, #WarehouseModule.AllItems do
		if WarehouseModule.AllItems[i].cid == cfgID then
			return WarehouseModule.AllItems[i]
		end
	end

	return nil
end

function WarehouseModule.GetSortItems(sortType, order)
	local SortTable = WarehouseModule.SelectAllItems

	if sortType ~= nil and sortType ~= -1 then
		if sortType == 1 then
			table.sort(SortTable, function(itemData1, itemData2)
				if itemData1:GetCfg().Quality == itemData2:GetCfg().Quality then
					return itemData1:GetCfg().Id > itemData2:GetCfg().Id
				end

				if order == 1 then
					return itemData1:GetCfg().Quality > itemData2:GetCfg().Quality
				else
					return itemData1:GetCfg().Quality < itemData2:GetCfg().Quality
				end
			end)
		elseif sortType == 2 then
			if order == 1 then
				table.sort(SortTable, function(itemData1, itemData2)
					if itemData1:GetCfg().ItemTypes == Constant.ItemType.Equip then
						if itemData1.equipData.lv == itemData2.equipData.lv then
							return itemData1:GetCfg().Id > itemData2:GetCfg().Id
						end

						return itemData1.equipData.lv < itemData2.equipData.lv
					elseif itemData1:GetCfg().ItemTypes == Constant.ItemType.Hero then
						if itemData1.skillData.lv == itemData2.skillData.lv then
							return itemData1:GetCfg().Id > itemData2:GetCfg().Id
						end

						return itemData1.skillData.lv < itemData2.skillData.lv
					else
						if itemData1:GetCfg().Quality == itemData2:GetCfg().Quality then
							return itemData1:GetCfg().Id > itemData2:GetCfg().Id
						end

						return itemData1:GetCfg().Quality > itemData2:GetCfg().Quality
					end
				end)
			else
				table.sort(SortTable, function(itemData1, itemData2)
					if itemData1:GetCfg().ItemTypes == Constant.ItemType.Equip then
						if itemData1.equipData.lv == itemData2.equipData.lv then
							return itemData1:GetCfg().Id > itemData2:GetCfg().Id
						end

						return itemData1.equipData.lv > itemData2.equipData.lv
					elseif itemData1:GetCfg().ItemTypes == Constant.ItemType.Skill then
						if itemData1.skillData.lv == itemData2.skillData.lv then
							return itemData1:GetCfg().Id > itemData2:GetCfg().Id
						end

						return itemData1.skillData.lv > itemData2.skillData.lv
					else
						if itemData1:GetCfg().Quality == itemData2:GetCfg().Quality then
							return itemData1:GetCfg().Id > itemData2:GetCfg().Id
						end

						return itemData1:GetCfg().Quality < itemData2:GetCfg().Quality
					end
				end)
			end
		elseif sortType == 3 then
			table.sort(SortTable, function(itemData1, itemData2)
				if itemData1.num == itemData2.num then
					return itemData1:GetCfg().Id > itemData2:GetCfg().Id
				end

				if order == 1 then
					return itemData1.num < itemData2.num
				else
					return itemData1.num > itemData2.num
				end
			end)
		elseif sortType == 4 then
			table.sort(SortTable, function(a, b)
				if a.createTime == b.createTime then
					return a:GetCfg().Quality > b:GetCfg().Quality
				end

				if order == 1 then
					return a.createTime < b.createTime
				else
					return a.createTime > b.createTime
				end
			end)
		end
	end

	return SortTable
end

function WarehouseModule.SortItemsByItemDepotType(items, depotType)
	local sortItems = Clone(items)

	table.sort(sortItems, function(a, b)
		if a:GetCfg().Quality ~= b:GetCfg().Quality then
			return a:GetCfg().Quality > b:GetCfg().Quality
		end

		if depotType == 3 then
			if a.equipData.lv ~= b.equipData.lv then
				return a.equipData.lv > b.equipData.lv
			end
		elseif depotType == 4 then
			if a.skillData.lv ~= b.skillData.lv then
				return a.skillData.lv > b.skillData.lv
			end
		elseif a.num ~= b.num then
			return a.num > b.num
		end

		if a.cid ~= b.cid then
			return a.cid > b.cid
		end

		return a.createTime > b.createTime
	end)

	return sortItems
end

function WarehouseModule.SortItems(items, sortType, ascending)
	table.sort(items, function(item1, item2)
		local success, value

		if sortType == 1 then
			success, value = item1:SortByNum(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortByQuality(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortByTime(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortById(item2, ascending)

			if success then
				return value
			end
		elseif sortType == 2 then
			success, value = item1:SortByTime(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortByQuality(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortByNum(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortById(item2, ascending)

			if success then
				return value
			end
		else
			success, value = item1:SortByQuality(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortByNum(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortByTime(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortById(item2, ascending)

			if success then
				return value
			end

			return false
		end
	end)
end

function WarehouseModule.SortEquips(items, sortType, ascending)
	table.sort(items, function(item1, item2)
		local success, value

		if sortType == 1 then
			success, value = item1.equipData:SortByLevel(item2.equipData, ascending)

			if success then
				return value
			end

			success, value = item1:SortByQuality(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortByTime(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortById(item2, ascending)

			if success then
				return value
			end
		elseif sortType == 2 then
			success, value = item1:SortByTime(item2, ascending)

			if success then
				return value
			end

			success, value = item1.equipData:SortByLevel(item2.equipData, ascending)

			if success then
				return value
			end

			success, value = item1:SortByQuality(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortById(item2, ascending)

			if success then
				return value
			end
		else
			success, value = item1:SortByQuality(item2, ascending)

			if success then
				return value
			end

			success, value = item1.equipData:SortByLevel(item2.equipData, ascending)

			if success then
				return value
			end

			success, value = item1:SortByTime(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortById(item2, ascending)

			if success then
				return value
			end
		end

		return false
	end)
end

function WarehouseModule.SortSkills(items, sortType, ascending)
	table.sort(items, function(item1, item2)
		local success, value

		if sortType == 1 then
			success, value = item1.skillData:SortByLevel(item2.skillData, ascending)

			if success then
				return value
			end

			success, value = item1:SortByQuality(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortByTime(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortById(item2, ascending)

			if success then
				return value
			end
		elseif sortType == 2 then
			success, value = item1:SortByQuality(item2, ascending)

			if success then
				return value
			end

			success, value = item1.skillData:SortByLevel(item2.skillData, ascending)

			if success then
				return value
			end

			success, value = item1:SortByTime(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortById(item2, ascending)

			if success then
				return value
			end
		elseif sortType == 3 then
			success, value = item1.skillData:SortByPurifyLv(item2.skillData, ascending)

			if success then
				return value
			end

			success, value = item1.skillData:SortByLevel(item2.skillData, ascending)

			if success then
				return value
			end

			success, value = item1:SortByQuality(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortByTime(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortById(item2, ascending)

			if success then
				return value
			end
		else
			success, value = item1:SortByQuality(item2, ascending)

			if success then
				return value
			end

			success, value = item1.skillData:SortByLevel(item2.skillData, ascending)

			if success then
				return value
			end

			success, value = item1:SortByTime(item2, ascending)

			if success then
				return value
			end

			success, value = item1:SortById(item2, ascending)

			if success then
				return value
			end
		end

		return false
	end)
end

function WarehouseModule.GetBagTabs(tabType, isSubTab)
	local tabs = {}

	for k, v in pairsCfg(CfgWarehouseTable) do
		if v.SuperId ~= nil and v.SuperId == tabType then
			table.insert(tabs, v)
		end
	end

	table.sort(tabs, function(tab1, tab2)
		return tab1.Index < tab2.Index
	end)

	return tabs
end

function WarehouseModule.GetSortType(TabType)
	local Sorts = {}
	local warehouseTable = WarehouseModule.GetWarehouseCfg(TabType)

	for i = 1, #warehouseTable.Sort do
		table.insert(Sorts, warehouseTable.SortDict[i])
	end

	return Sorts
end

function WarehouseModule.GetWarehouseCfg(cid)
	return CfgWarehouseTable[cid]
end

function WarehouseModule.GetUseMoneyIsEnough(cid, num)
	local isEnough = false
	local ownnum = WarehouseModule.GetItemNumByCfgID(cid)

	isEnough = num <= ownnum

	return isEnough
end

function WarehouseModule.GetPlayerGoldNum()
	return WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.GOLD)
end

function WarehouseModule.GetPlayerStrengthNum()
	return WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.STRENGTH)
end

function WarehouseModule.GetPlayerNormalMoneyNum()
	return WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.NORMAL_MONEY)
end

function WarehouseModule.GetPlayerTollMoneyNum()
	return WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.TOLL_MONEY)
end

function WarehouseModule.GetAgentSkillDataList()
	local agentSkillDataDict = {}

	for _, skill in pairsCfg(CfgSkillTable) do
		if skill.SkillType == 5 then
			agentSkillDataDict[skill.Id] = skill
		end
	end

	local result = {}

	for k, item in pairs(WarehouseModule.AllItems) do
		if agentSkillDataDict[item:GetCfg().LikeId] ~= nil then
			table.insert(result, item.skillData)
		end
	end

	table.sort(result, function(skillA, skillB)
		local a = ConditionModule.Check(CfgItemTable[skillA.itemCid].UnlockConditionId) and 1 or 0
		local b = ConditionModule.Check(CfgItemTable[skillB.itemCid].UnlockConditionId) and 1 or 0

		if a == b then
			return skillA.itemCid < skillB.itemCid
		end

		return b < a
	end)

	return result
end

function WarehouseModule.GetAgentSkillDataListByType(type)
	local agentSkillDataDict = {}

	for _, skill in pairsCfg(CfgSkillTable) do
		if skill.SkillType == 5 then
			agentSkillDataDict[skill.Id] = skill
		end
	end

	local result = {}

	for k, item in pairs(WarehouseModule.AllItems) do
		if agentSkillDataDict[item:GetCfg().LikeId] ~= nil and ConditionModule.Check(item:GetCfg().UnlockConditionId) then
			local skillData = Clone(item.skillData)

			if type == 1 then
				skillData.skillCid = item.skillData:GetCfg().SubSkills[1]
			elseif type == 2 then
				skillData.skillCid = item.skillData:GetCfg().SubSkills[2]
			end

			table.insert(result, skillData)
		end
	end

	return result
end

function WarehouseModule.GetItemCfgByLinkeIDAndType(linkID, itemTyps, itemSubTypes)
	for k, v in pairsCfg(CfgItemTable) do
		if v.ItemTypes == itemTyps and itemSubTypes == v.ItemSubTypes and v.LikeId == linkID then
			return v
		end
	end

	return nil
end

function WarehouseModule.GetAllBagItemByScreenData(depotType, screenData)
	local items = {}

	ForPairs(WarehouseModule.AllItems, function(_, _itemData)
		if _itemData:GetCfg().DepotType ~= depotType then
			return
		end

		if screenData ~= nil then
			local checkData

			if screenData.screenType == Constant.CommonScreenType.Equip then
				checkData = _itemData.equipData
			elseif screenData.screenType == Constant.CommonScreenType.Skill then
				checkData = _itemData.skillData
			end

			if checkData ~= nil and not CommonScreenModule.ScreenCheck(checkData, screenData) then
				return
			end
		end

		table.insert(items, _itemData)
	end)

	return items
end

function WarehouseModule.GetAllBagItemByTyprAndSubType(type, subType)
	local items = {}

	ForPairs(WarehouseModule.AllItems, function(_, _itemData)
		if _itemData:GetCfg().ItemTypes == type and _itemData:GetCfg().ItemSubTypes == subType then
			table.insert(items, _itemData)
		end
	end)

	return items
end

function WarehouseModule.GetDecomposeReward(type, itemIdList)
	local discreteData, currencyRatio

	if type == Constant.ItemType.Skill then
		discreteData = CfgDiscreteDataTable[106].Data
		currencyRatio = CfgDiscreteDataTable[2].Data[1]
	end

	local allExp = 0

	ForPairs(itemIdList, function(_, itemId)
		local itemData = WarehouseModule.GetItemDataById(itemId)

		if itemData == nil then
			return
		end

		if type == Constant.ItemType.Skill then
			local skillLevelCfg = itemData.skillData:GetSkillCfgByLevel()

			allExp = allExp + skillLevelCfg.OfferExp
		end
	end)

	local result = WarehouseModule.CalculateConvertibleItems(WarehouseModule.ParseItemExpData(discreteData), allExp)

	if allExp > 0 then
		table.insert(result, 1, {
			cid = Constant.ItemCid.GOLD,
			count = allExp * currencyRatio / 100
		})
	end

	return result
end

function WarehouseModule.GetEquipDecomposeReward(type, itemIdList)
	local discreteData, currencyRatio

	if type == Constant.ItemType.Equip then
		discreteData = CfgDiscreteDataTable[107].Data
		currencyRatio = CfgDiscreteDataTable[24].Data[1]
	end

	local allExp = 0

	ForPairs(itemIdList, function(_, itemId)
		local itemData = WarehouseModule.GetItemDataById(itemId)

		if itemData == nil then
			return
		end

		if type == Constant.ItemType.Equip then
			local equipLevelCfg = itemData.equipData:GetEquipCfgByLevel()

			allExp = allExp + equipLevelCfg.OfferExp
		end
	end)

	local result = WarehouseModule.CalculateConvertibleItems(WarehouseModule.ParseItemExpData(discreteData), allExp)

	if allExp > 0 then
		table.insert(result, 1, {
			cid = Constant.ItemCid.GOLD,
			count = allExp * currencyRatio / 100
		})
	end

	return result
end

function WarehouseModule.ParseItemExpData(data)
	local items = {}

	for i = 1, #data, 2 do
		table.insert(items, {
			cid = data[i],
			exp = data[i + 1]
		})
	end

	return items
end

function WarehouseModule.CalculateConvertibleItems(items, exp)
	local result = {}

	for _, item in ipairs(items) do
		if exp >= item.exp then
			local count = math.floor(exp / item.exp)

			table.insert(result, {
				cid = item.cid,
				count = count
			})

			exp = exp - count * item.exp
		end
	end

	return result
end

function WarehouseModule.GetSkillTipsByLevel(skillCid, level)
	local result
	local skillCfg = CfgSkillTable[skillCid]

	if skillCfg.IsDiy then
		ForPairs(CfgSkillRefineTable, function(_, _cfg)
			if _cfg.Skill ~= skillCid then
				return
			end

			if _cfg.SkillRefineLv ~= level then
				return
			end

			result = _cfg.SkillTips

			return true
		end)
	else
		ForPairs(CfgSkillLevelTable, function(_, _cfg)
			if _cfg.Skill ~= skillCid then
				return
			end

			if _cfg.SkillLv ~= level then
				return
			end

			result = _cfg.SkillTips

			return true
		end)
	end

	return result
end
