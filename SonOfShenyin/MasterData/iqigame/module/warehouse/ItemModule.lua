-- chunkname: @IQIGame\\Module\\Warehouse\\ItemModule.lua

ItemModule = {}

function ItemModule.OpenTip(pItemCell, cbParams)
	ItemModule.__OpenCommonTips(pItemCell, pItemCell.ItemCfgOrData, pItemCell.ForShow, pItemCell.HideTipsSource, cbParams)
end

function ItemModule.OpenTipByData(itemCfgOrData, forShow, hideSource, cbParams)
	ItemModule.__OpenCommonTips(nil, itemCfgOrData, forShow, hideSource, cbParams)
end

function ItemModule.OpenTipByCid(cid, forShow, hideSource, cbParams)
	local itemData = ItemData.CreateByCIDAndNumber(cid, 1)

	ItemModule.__OpenCommonTips(nil, itemData, forShow, hideSource, cbParams)
end

function ItemModule.__OpenCommonTips(itemCell, itemData, forShow, hideSource, cbParams)
	if itemData == nil then
		return
	end

	local uiName, tipsData = ItemModule.GetCommonTipsDataByItemData(itemData, forShow, hideSource, cbParams)

	UIModule.Open(uiName, Constant.UILayer.Tooltip, tipsData)
end

function ItemModule.GetCommonTipsDataByItemData(itemData, forShow, hideSource, cbParams)
	local _cbParams = cbParams

	if _cbParams == nil then
		_cbParams = {}
	end

	_cbParams.forShow = forShow
	_cbParams.hideSource = hideSource

	local tipsData = {
		data = itemData,
		cbParams = _cbParams
	}
	local uiName = Constant.UIControllerName.CommonItemTipsUI

	if itemData.Type == Constant.ItemType.Gift then
		uiName = Constant.UIControllerName.CommonGiftTipsUI
	elseif itemData.Type == Constant.ItemType.Skill then
		uiName = Constant.UIControllerName.CommonSkillTipsUI
	elseif itemData.Type == Constant.ItemType.Equip then
		uiName = Constant.UIControllerName.CommonEquipTipsUI
	elseif itemData.Type == Constant.ItemType.EquipSuitPreview then
		uiName = Constant.UIControllerName.CommonEquipSuitTipsUI
	end

	return uiName, tipsData
end

function ItemModule.OpenItemTipsByItemData(itemData, forShow, hideSource)
	if itemData == nil then
		logError("ItemModule.OpenItemTipsByItemData : itemData is nil.")

		return
	end

	local itemConfig = itemData:GetCfg()

	if itemConfig == nil then
		logError("ItemModule.OpenItemTipsByItemData : itemCid={0} is invalid.", itemData.cid)

		return
	end

	forShow = forShow ~= nil and forShow or true
	hideSource = hideSource ~= nil and hideSource or false

	local isSKinItem, skinCid = SkinModule.IsSkinItemByItemCfg(itemConfig)

	if isSKinItem then
		return
	end

	ItemModule.OpenTipByData(itemData, forShow, hideSource)
end

function ItemModule.GenerateUseItemPOD(id, num, selectIndex)
	if type(id) == "number" then
		id = tostring(id)
	end

	local useItemPOD = {
		id = id,
		num = num or 1,
		selectIndex = selectIndex or 0
	}

	return useItemPOD
end

function ItemModule.ReadItemFlag(itemId)
	net_item.readItemFlag(itemId)
end

function ItemModule.UseItem(useItemPODs)
	net_item.useItem(useItemPODs)
end

function ItemModule.CompositeItem(composites)
	net_item.compositeItem(composites)
end

function ItemModule.SellItem(itemData, num)
	if itemData.IsMazeItem then
		local item = {
			ItemID = itemData.id,
			Num = num
		}

		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_SELL_ITEM, item)
	else
		net_item.sellItem(itemData.id, num)
	end
end

function ItemModule.DestroyItem(itemData)
	if itemData.IsMazeItem then
		local item = {
			Num = 1,
			ItemID = itemData.id
		}

		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_DESTORY_ITEM, item)
	else
		net_item.destroyItem(itemData.id)
	end
end

function ItemModule.DecomposeItem(itemList)
	local decomposeItemList = {}

	ForPairs(itemList, function(_, _itemId)
		decomposeItemList[_itemId] = 1
	end)
	net_item.disItem(decomposeItemList)
end

function ItemModule.DisItemResult(items)
	NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, items)
	EventDispatcher.Dispatch(EventID.DecomposeItemResult)
	EventDispatcher.Dispatch(EventID.EquipDecomposeItemResult)
end

function ItemModule.CheckCanUse(itemData, num)
	return WarehouseModule.CheckCanUse(itemData, num)
end

function ItemModule.CheckCanUseMazeItem(id, num)
	local csItemData = MazeDataModule.FindItemByInstanceID(id)

	if csItemData == nil then
		return false, ""
	end

	local cfgItemData = csItemData:GetCfg()

	return ConditionModule.Check(cfgItemData.UseConditionID)
end

function ItemModule.IsInCorrectUseArea(cfgItemData)
	local useArea = cfgItemData.UseArea

	if useArea == Constant.Item.USE_AREA_MAZE then
		return true
	elseif useArea == Constant.Item.USE_AREA_CITY then
		return true
	end

	return false
end

function ItemModule.IsSkinGiftItemByItemCid(itemCid)
	if type(itemCid) == "string" then
		itemCid = tonumber(itemCid)
	end

	local itemConfig = CfgItemTable[itemCid]

	if itemConfig ~= nil and itemConfig.ItemTypes == Constant.ItemType.Gift and itemConfig.ItemSubTypes == 3 then
		return true
	end

	return false
end

function ItemModule.GetGiftPreviewItems(itemCfg)
	local previewItems = {}
	local itemList = itemCfg.ActionParams

	if itemCfg.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.Gift].Random then
		itemList = ItemModule.__GetRandomGiftPreviewItemList(itemCfg)
	elseif itemCfg.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.Gift].SubGift then
		itemList = {}
	end

	for i = 1, #itemList, 2 do
		local itemData = {}

		itemData.cid = itemList[i]
		itemData.count = itemList[i + 1]

		table.insert(previewItems, itemData)
	end

	return previewItems
end

function ItemModule.__GetRandomGiftPreviewItemList(cfgData)
	local result = {}
	local dropId = cfgData.ActionParams[1]
	local dropCfg = CfgDropLibTable[dropId]

	if dropCfg == nil then
		logError("随机礼包掉落配置错误 DropLib.csv 中找不到ID " .. tostring(dropId) .. " 请确认道具表 " .. cfgData.Id .. " 的 ActionParams 参数是否配置正确")

		return result
	end

	if #dropCfg.RandomIds ~= #dropCfg.RandomCount then
		logError("随机礼包掉落配置错误 DropLib.csv  " .. tostring(dropId) .. " 掉落物品和掉落数量不匹配 ")

		return result
	end

	for i = 1, #dropCfg.RandomIds do
		table.insert(result, dropCfg.RandomIds[i])
		table.insert(result, dropCfg.RandomCount[i])
	end

	return result
end

function ItemModule.CommonExpItemFilter(needExp, totalExpData, limitCost)
	local surplusExp = needExp
	local surplusCost = limitCost
	local result = {}
	local totalExp = 0
	local totalCost = 0
	local totalItemExp = 0
	local totalItemCost = 0
	local totalItemCount = 0
	local totalDataCount = 0

	for i = 1, #totalExpData do
		totalItemCount = totalItemCount + totalExpData[i].num
		totalItemExp = totalItemExp + totalExpData[i].num * totalExpData[i].exp
		totalItemCost = totalItemCost + totalExpData[i].num * totalExpData[i].exp * totalExpData[i].unitCost
		totalDataCount = totalDataCount + 1
	end

	if totalItemExp <= needExp and totalItemCost <= limitCost then
		for k, v in pairs(totalExpData) do
			result[v.id] = v.num
		end

		return result
	end

	table.sort(totalExpData, function(a, b)
		if a.weight == b.weight then
			return a.exp > b.exp
		else
			return a.weight > b.weight
		end
	end)

	local filterSuccess = false

	for i = 1, #totalExpData do
		local _itemData, _surplusExp = ItemModule.__CheckExpItem(surplusExp, totalExpData[i], surplusCost, nil)

		if _itemData.num ~= 0 then
			result[_itemData.id] = _itemData.num
			totalExp = totalExp + _itemData.num * totalExpData[i].exp
			totalCost = totalCost + _itemData.num * totalExpData[i].unitCost

			if _surplusExp <= 0 then
				filterSuccess = true

				break
			end

			surplusExp = _surplusExp
			surplusCost = surplusCost - _itemData.num * totalExpData[i].unitCost
		end
	end

	return result, totalCost, totalExp
end

function ItemModule.__CheckExpItem(needExp, expItem, limitCost, conditionFunc)
	local result = {
		num = 0,
		id = expItem.id
	}
	local surplusExp = needExp

	if conditionFunc ~= nil and not conditionFunc(expItem) then
		return result, surplusExp
	end

	local costCnt = math.floor(limitCost / (expItem.exp * expItem.unitCost))
	local maxCount = math.min(costCnt, expItem.num)
	local canMore = true
	local tempExp = 0

	for _ = 1, maxCount do
		tempExp = surplusExp - expItem.exp

		if tempExp < 0 then
			if expItem.tolerance <= 0 then
				break
			end

			if math.abs(tempExp) > expItem.tolerance and canMore == false then
				break
			end

			canMore = false
		end

		surplusExp = tempExp
		result.num = result.num + 1
	end

	return result, surplusExp
end

function ItemModule.__GetOverflowMinExpItem(needExp, limitCost, totalExpItems, excludeExpItems)
	local tempItem

	local function checkItem(_item)
		if _item.unitCost > limitCost then
			return false
		end

		if _item.exp < needExp then
			return false
		end

		if excludeExpItems[_item.id] == nil then
			return true
		end

		return _item.num - excludeExpItems[item.id] > 0
	end

	local function compareItem(_item)
		if tempItem == nil then
			tempItem = _item
		end

		if _item.exp < tempItem.exp then
			tempItem = _item
		end
	end

	for i = 1, #totalExpItems do
		local item = totalExpItems[i]

		if checkItem(item) then
			compareItem(item)
		end
	end

	return tempItem
end

function ItemModule.ReadItemFlagResult(itemPOD)
	return
end

function ItemModule.ExcludeExpItem_CountExp(itemShowList)
	local tb = {}
	local expNum = 0

	for _, v in pairs(itemShowList) do
		if v.cid ~= Constant.ItemCid.Exp then
			table.insert(tb, v)
		else
			expNum = expNum + v.num
		end
	end

	return tb, expNum
end

function ItemModule.ItemShowListSort(itemShowList)
	table.sort(itemShowList, function(a, b)
		if a.tag ~= b.tag then
			return a.tag > b.tag
		end

		local cfgItemA = CfgUtil.GetItemCfgDataWithID(a.cid)
		local cfgItemB = CfgUtil.GetItemCfgDataWithID(b.cid)

		if cfgItemA.Quality ~= cfgItemB.Quality then
			return cfgItemA.Quality > cfgItemB.Quality
		end

		return cfgItemA.ItemTypes > cfgItemB.ItemTypes
	end)

	return itemShowList
end

function ItemModule.ExcludeNotShowItem(itemArray)
	local len = #itemArray

	for i = len, 1, -1 do
		local cfgItem = CfgUtil.GetItemCfgDataWithID(itemArray[i].cid)

		if cfgItem.IsHide == Constant.ItemHideType.All then
			table.remove(itemArray, i)
		end
	end

	return itemArray
end
