-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/controller/EquipIntensifyController.lua

module("logic.extensions.equipment.controller.EquipIntensifyController", package.seeall)

local M = class("EquipIntensifyController", BaseController)

function M:ctor()
	M.super.ctor(self)

	self._equipFilterCfg = CommonEquipFilterCfg.New()
	self._curPart = false
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._equipFilterCfg:reset()
	self._equipFilterCfg:addFilterWhiteList(CommEnum.EquipFilterKind.EquipPart, CommEnum.EquipFilterKind.D6Part)
end

function M:setOperatingEquip(equipmentData)
	self._equipmentData = equipmentData
end

function M:getOperatingEquip()
	return self._equipmentData
end

function M:isMultipleItem(itemData)
	local type = itemData:getType()

	if type == GameEnum.ItemTypeEnum.EquipItemType or type == GameEnum.ItemTypeEnum.DiceItem then
		return false
	end

	return true
end

function M:getPerItemExp(itemData)
	local type = itemData:getType()

	if type == GameEnum.ItemTypeEnum.EquipItemType or type == GameEnum.ItemTypeEnum.DiceItem then
		return itemData:getDecomposedCanGetExp()
	end

	return EquipmentConfig.instance:getItemAddEquipExp(itemData:getItemId())
end

function M:getCurrencyPerExp()
	return EquipmentConfig.instance:getFloatNum(EquipEnum.goldPerExp)
end

function M:setSortFun(BackpackItemSortData)
	self._backpackItemSortData = BackpackItemSortData
end

function M:setEquipFilterCfgSuit(suit)
	self._equipFilterCfg:setSuitId(suit)
end

function M:setEquipFilterCfgDices(dices)
	self._equipFilterCfg:setDiceIds(dices)
end

function M:sortList(list)
	if not self._backpackItemSortData then
		self._backpackItemSortData = BackpackItemSortData.New(CommEnum.MainBackpackSortType.Experience, false)
	end

	table.sort(list, ItemUtil.commonSortFunc)
	BackpackUtil.setOriginOrder(list)
	BackpackUtil.sortShownItems(list, self._backpackItemSortData, false)
end

function M:getIntensifyItemList()
	return self._intensifyItemList
end

function M:getIntensifyEquipList()
	table.sort(self._intensifyEquipList, function(itemA, itemB)
		if itemA:getDecomposedCanGetExp() ~= itemB:getDecomposedCanGetExp() then
			return itemA:getDecomposedCanGetExp() < itemB:getDecomposedCanGetExp()
		end

		return itemA:getQuality() < itemB:getQuality()
	end)

	return self._intensifyEquipList
end

function M:getIntensifyDiceList()
	table.sort(self._intensifyDiceList, function(itemA, itemB)
		return itemA:getQuality() < itemB:getQuality()
	end)

	return self._intensifyDiceList
end

function M:getCanIntensifyMaterials(uuid)
	local list = {}

	self._intensifyItemList = {}
	self._intensifyEquipList = {}
	self._intensifyDiceList = {}

	local canAddList = EquipmentConfig.instance:getEquipExpItemDataList()

	for k, v in ipairs(canAddList) do
		local itemlist = ItemModel.instance:getItemsByItemId(v.itemId)

		for i = 1, #itemlist do
			local item = itemlist[i]

			if item:getCount() > 0 then
				table.insert(list, item)
				table.insert(self._intensifyItemList, item)
			end
		end
	end

	local equipMoList = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EquipItemType)

	equipMoList = FilterCfgUtil.commonEquipsFilter(equipMoList, self._equipFilterCfg)

	self:sortList(equipMoList)

	for i = 1, #equipMoList do
		local item = equipMoList[i]

		if not item:getIsEquip() and item:getUuid() ~= uuid then
			table.insert(list, item)
			table.insert(self._intensifyEquipList, item)
		end
	end

	return list
end

function M:isEquipCanLvUpAnyMore(equip, lvup)
	if not equip or equip:isMaxLv() then
		return false
	end

	local canAddList = EquipmentConfig.instance:getEquipExpItemDataList()
	local canAddExp = 0

	for k, v in ipairs(canAddList) do
		local itemlist = ItemModel.instance:getItemsByItemId(v.itemId)

		for i = 1, #itemlist do
			local item = itemlist[i]

			if not item:getIsLock() and item:getCount() > 0 then
				local exp = EquipmentConfig.instance:getItemAddEquipExp(item:getItemId())

				canAddExp = canAddExp + item:getCount() * exp
			end
		end
	end

	local goldHas = ItemModel.instance:getItemCountByItemId(GameEnum.CurrencyCodeEnum.LzbCode)
	local needExp, goldNeed = self:getEquipLvConsumeInfo(equip, lvup or 1)

	return needExp <= canAddExp and goldNeed <= goldHas
end

function M:getEquipLvConsumeInfo(equip, lvUp)
	if lvUp <= 0 then
		return 0, 0, 0
	end

	local lv = equip:getLevel()
	local needExp = -equip:getCurrentExp()

	for i = 0, lvUp - 1 do
		needExp = needExp + equip:getLevelUpNeedExp(lv + i)
	end

	local needCurrency = needExp * EquipIntensifyController.instance:getCurrencyPerExp()

	return needExp, needCurrency
end

M.instance = M.New()

return M
