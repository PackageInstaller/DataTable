-- chunkname: @IQIGame\\Module\\Warehouse\\ItemModule.lua

ItemModule = {}

function ItemModule.OpenTip(pItemCell)
	ItemModule.OpenTipByData(pItemCell.ItemCfgOrData, pItemCell.ForShow, pItemCell.HideTipsSource)
end

function ItemModule.OpenTipByData(itemCfgOrData, forShow, hideSource)
	if itemCfgOrData == nil then
		return
	end

	if itemCfgOrData.Type == 3 or itemCfgOrData.Type == Constant.ItemType.EvilErosionEquip then
		UIModule.Open(Constant.UIControllerName.EquipUI, Constant.UILayer.UI, {
			data = {
				itemCfgOrData
			},
			forShow = forShow
		})
	else
		UIModule.Open(Constant.UIControllerName.ItemTipsUI, Constant.UILayer.Mid, {
			data = itemCfgOrData,
			forShow = forShow,
			hideSource = hideSource
		})
	end
end

function ItemModule.UseItem(itemData, num)
	if ItemModule.IsClientUseItem(itemData:GetCfg()) then
		ItemModule.ClientUseItem(itemData, num)

		return
	end

	if itemData.IsMazeItem then
		local item = {
			ItemID = itemData.id,
			Num = num
		}

		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_USE_ITEM, item)
	else
		net_item.useItem(itemData.id, num)
	end
end

function ItemModule.IsClientUseItem(cfgItemData)
	if cfgItemData.Type == 2 and cfgItemData.SubType == 47 then
		return true
	end

	return false
end

function ItemModule.ClientUseItem(itemData, num)
	local cfgItemData = itemData:GetCfg()

	if cfgItemData.Type == 2 and cfgItemData.SubType == 47 then
		UIModule.Open(Constant.UIControllerName.ItemLetterTipsUI, Constant.UILayer.UI, {
			itemCid = cfgItemData.Id
		})
	end
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

function ItemModule.CheckCanUse(itemData, num)
	if not ItemModule.IsInCorrectUseArea(itemData:GetCfg()) then
		return false, nil, false
	end

	if ItemModule.IsClientUseItem(itemData:GetCfg()) then
		return true, nil, true
	end

	if itemData.IsMazeItem then
		return MazeDataModule.CheckCanUse(itemData.id, num)
	else
		return WarehouseModule.CheckCanUse(itemData, num)
	end
end

function ItemModule.IsInCorrectUseArea(cfgItemData)
	local useArea = cfgItemData.UseArea

	if useArea == Constant.Item.USE_AREA_MAZE and PlayerModule.InMaze then
		return true
	elseif useArea == Constant.Item.USE_AREA_CITY and not PlayerModule.InMaze then
		return true
	end

	return false
end

function ItemModule.CheckUseCostNumEnough(cfgItemData, costNum)
	if costNum == nil then
		costNum = 1
	end

	for i, v in pairs(cfgItemData.UseCostIDNum) do
		if i % 2 == 1 then
			local ownCount = WarehouseModule.GetItemNumByCfgID(v)
			local targetCostCount = cfgItemData.UseCostIDNum[i + 1]

			if cfgItemData.Id == v then
				targetCostCount = targetCostCount + 1
			end

			if ownCount < targetCostCount * costNum then
				return false
			end
		end
	end

	return true
end

function ItemModule.IsOptionalGift(cfgItemData)
	return cfgItemData.OptionalGiftPack ~= 0
end

function ItemModule.SendChooseGift(itemId, chooses, useNum)
	net_item.optionalGift(itemId, chooses, useNum)
end

function ItemModule.IsSoulItem(cfgItemData)
	for i = 1, #cfgItemData.EffectTypeID do
		if cfgItemData.EffectTypeID[i] == 2 then
			return true, cfgItemData.EffectTypeParam[i][1]
		end
	end

	return false
end
