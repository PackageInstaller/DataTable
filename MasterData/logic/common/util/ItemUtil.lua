-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/ItemUtil.lua

module("logic.common.util.ItemUtil", package.seeall)

local BackpackShowType = CommEnum.MainBackpackShowType
local ItemTypeEnum = GameEnum.ItemTypeEnum
local HouseItemSubTypeEnum = GameEnum.HouseItemSubTypeEnum
local ITEM_MARK_BIT_NUM = 1000
local _itemClass = {
	[ItemTypeEnum.EquipItemType] = EquipmentData,
	[ItemTypeEnum.EchoItemType] = EchoItemData,
	[ItemTypeEnum.PuzzlePiecesItem] = PuzzleItemData,
	[ItemTypeEnum.DiceItem] = D6ItemData,
	[ItemTypeEnum.FurnitureItemType] = FurnitureData,
	[ItemTypeEnum.DrawingItemType] = DrawingItemData,
	[ItemTypeEnum.HouseItemType] = BaseMaterialItemData,
	[ItemTypeEnum.HeroType] = HeroItemData,
	[ItemTypeEnum.PrefabItem] = PrefabItemData
}
local kFilterTypes = {
	GameEnum.ItemTypeEnum.CurrencyItemType,
	GameEnum.ItemTypeEnum.EquipItemType,
	GameEnum.ItemTypeEnum.EchoItemType,
	GameEnum.ItemTypeEnum.FurnitureItemType,
	GameEnum.ItemTypeEnum.DrawingItemType,
	GameEnum.ItemTypeEnum.AirScene,
	GameEnum.ItemTypeEnum.AirBuilding
}
local _commSortType = {
	[BackpackShowType.EquipShowType] = true,
	[BackpackShowType.D6ShowType] = true,
	[BackpackShowType.EchoShowType] = true,
	[BackpackShowType.CardChipShowType] = true,
	[BackpackShowType.EchoCardPackType] = true
}

function getItemKeyByTS(type, subType)
	return type * 1000 + subType
end

function isItemOverTime(itemData)
	local expireTime = tonumber(itemData:getExpireTime())
	local isOverTime = expireTime ~= 0 and expireTime <= ServerTime.now() * 1000

	return isOverTime
end

function createItemData(info)
	local itemId = info.itemId
	local type = getItemTypeByItemId(itemId)
	local itemClass = _itemClass[type] or ItemData

	return itemClass.New(info)
end

function itemEqual(item1, item2)
	return item1:getUuid() == item2:getUuid()
end

function getItemTypeByItemId(itemId)
	itemId = itemId or 0

	local value = math.floor(itemId / ITEM_MARK_BIT_NUM)
	local type = math.floor(value / 100)
	local subType = 0

	if table.indexof(kFilterTypes, type) then
		local itemCO = BackpackConfig.instance:getItemInfoByItemId(itemId)

		subType = itemCO and itemCO.subType or 0
	else
		subType = value % (type * 100)
	end

	return type, subType
end

function sortItemList(list, showType, isRoom)
	if not list or #list < 1 then
		return
	end

	local sortFun = ItemUtil.sortItemsCompare

	if not isRoom and _commSortType[showType] then
		sortFun = ItemUtil.commonSortFunc
	end

	table.sort(list, sortFun)
end

function sortItemsCompare(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	if itemA:getExpireTime() ~= itemB:getExpireTime() then
		if itemA:getExpireTime() * itemB:getExpireTime() == 0 then
			return itemA:getExpireTime() > itemB:getExpireTime()
		else
			return itemA:getExpireTime() < itemB:getExpireTime()
		end
	end

	if itemA:getPriority() ~= itemB:getPriority() then
		return itemA:getPriority() > itemB:getPriority()
	end

	return commonSortFunc(itemA, itemB)
end

function ItemCompareByAddTime(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	return itemA:getAddTime() > itemB:getAddTime()
end

function sortEchoItemCompare(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	if itemA:getIsEquip() ~= nil and itemB:getIsEquip() ~= nil and itemA:getIsEquip() ~= itemB:getIsEquip() then
		return sortByBool(itemA:getIsEquip(), itemB:getIsEquip())
	end

	if itemA:getIsLock() ~= itemB:getIsLock() then
		return sortByBool(itemA:getIsLock(), itemB:getIsLock())
	end

	if itemA:getLevel() ~= itemB:getLevel() then
		return itemA:getLevel() > itemB:getLevel()
	end

	return -1
end

function sortByBool(first, second)
	return first and not second
end

function sortEquipItemCompare(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	if itemA:getIsEquip() ~= itemB:getIsEquip() then
		return sortByBool(itemA:getIsEquip(), itemB:getIsEquip())
	end

	if itemA:getIsLock() ~= itemB:getIsLock() then
		return sortByBool(itemA:getIsLock(), itemB:getIsLock())
	end

	if itemA:getSuitId() ~= itemB:getSuitId() then
		return itemA:getSuitId() > itemB:getSuitId()
	end

	if #itemA:getAllDiceAttr() ~= #itemB:getAllDiceAttr() then
		return #itemA:getAllDiceAttr() > #itemB:getAllDiceAttr()
	end

	if itemA:getLevel() ~= itemB:getLevel() then
		return itemA:getLevel() > itemB:getLevel()
	end

	if itemA:hasOriginalD6() ~= itemB:hasOriginalD6() then
		return sortByBool(itemA:hasOriginalD6(), itemB:hasOriginalD6())
	end

	if itemA:getPart() ~= itemB:getPart() then
		return itemA:getPart() < itemB:getPart()
	end

	if itemA:getExtraDiceAttrNum() ~= itemB:getExtraDiceAttrNum() then
		return itemA:getExtraDiceAttrNum() > itemB:getExtraDiceAttrNum()
	end

	return -1
end

function sortD6ItemCompare(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	if itemA:getPart() ~= itemB:getPart() then
		return itemA:getPart() < itemB:getPart()
	end

	if itemA:getMaxAttrLevel() ~= itemB:getMaxAttrLevel() then
		return itemA:getMaxAttrLevel() > itemB:getMaxAttrLevel()
	end

	return itemA:getItemId() > itemB:getItemId()
end

function sortFurnitureItemCompare(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	if itemA:getAtmosphere() ~= itemB:getAtmosphere() then
		return itemA:getAtmosphere() > itemB:getAtmosphere()
	elseif itemA:getCfgSpAtmosValAndTyp() ~= itemB:getCfgSpAtmosValAndTyp() then
		return itemA:getCfgSpAtmosValAndTyp() > itemB:getCfgSpAtmosValAndTyp()
	elseif itemA:getSubType() ~= itemB:getSubType() then
		return itemA:getSubType() < itemB:getSubType()
	elseif itemA:getItemId() ~= itemB:getItemId() then
		return itemA:getItemId() < itemB:getItemId()
	else
		return itemA:getUuid() < itemB:getUuid()
	end
end

function sortTradeItemCompareByQuality(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	if itemA:getQuality() ~= itemB:getQuality() then
		return itemA:getQuality() > itemB:getQuality()
	elseif itemA:getSubType() ~= itemB:getSubType() then
		return itemA:getSubType() < itemB:getSubType()
	else
		return itemA:getItemId() < itemB:getItemId()
	end
end

function sortTradeItemCompareByCategory(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	if itemA:getSubType() ~= itemB:getSubType() then
		return itemA:getSubType() < itemB:getSubType()
	elseif itemA:getQuality() ~= itemB:getQuality() then
		return itemA:getQuality() > itemB:getQuality()
	else
		return itemA:getItemId() < itemB:getItemId()
	end
end

function sortPackItems(packItems)
	table.sort(packItems, sortItemsCompare)
end

function getGiftTypeByItemId(itemId)
	return math.floor(itemId % 1000 / 10)
end

local function _getRewardTabSort(item)
	local rewardTag = item:getRewardTag()

	return RewardConfig.instance:getRewardTagByOptType(rewardTag).sort
end

local _indexType = {
	SpecialCtg = 2,
	NormalCtg = 3,
	SpecialID = 1
}

local function _getSortIndex(sortEnum, item)
	local list = ItemCommonSortConfig.instance:getSortList(sortEnum)

	if sortEnum == _indexType.SpecialID then
		return table.indexof(list, item:getItemId()) or #list + 1
	end

	if sortEnum == _indexType.SpecialCtg then
		return table.indexof(list, item:getType()) or #list + 1
	end

	if sortEnum == _indexType.NormalCtg then
		return table.indexof(list, item:getType()) or #list + 1
	end

	printError("未定义的排序类型" .. tostring(sortEnum))
end

function sortPropItemCompare(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	if itemA:getExpireTime() ~= itemB:getExpireTime() then
		if itemA:getExpireTime() * itemB:getExpireTime() == 0 then
			return itemA:getExpireTime() > itemB:getExpireTime()
		else
			return itemA:getExpireTime() < itemB:getExpireTime()
		end
	end
end

local function _getSortByType(itemA, itemB)
	if itemA:getType() == GameEnum.ItemTypeEnum.EquipItemType then
		return sortEquipItemCompare(itemA, itemB)
	elseif itemA:getType() == GameEnum.ItemTypeEnum.EchoItemType then
		return sortEchoItemCompare(itemA, itemB)
	end

	return -1
end

local function _sortBySpecial()
	return
end

function commonSortFunc(itemA, itemB)
	if _getRewardTabSort(itemA) ~= _getRewardTabSort(itemB) then
		return _getRewardTabSort(itemA) > _getRewardTabSort(itemB)
	elseif _getSortIndex(_indexType.SpecialID, itemA) ~= _getSortIndex(_indexType.SpecialID, itemB) then
		return _getSortIndex(_indexType.SpecialID, itemA) < _getSortIndex(_indexType.SpecialID, itemB)
	elseif _getSortIndex(_indexType.SpecialCtg, itemA) ~= _getSortIndex(_indexType.SpecialCtg, itemB) then
		return _getSortIndex(_indexType.SpecialCtg, itemA) < _getSortIndex(_indexType.SpecialCtg, itemB)
	elseif itemA:getQuality() ~= itemB:getQuality() then
		return itemA:getQuality() > itemB:getQuality()
	elseif _getSortIndex(_indexType.NormalCtg, itemA) ~= _getSortIndex(_indexType.NormalCtg, itemB) then
		return _getSortIndex(_indexType.NormalCtg, itemA) < _getSortIndex(_indexType.NormalCtg, itemB)
	elseif _getSortByType(itemA, itemB) ~= -1 then
		return _getSortByType(itemA, itemB)
	elseif itemA:getSubType() ~= itemB:getSubType() then
		return itemA:getSubType() > itemB:getSubType()
	elseif itemA:getItemId() ~= itemB:getItemId() then
		return itemA:getItemId() > itemB:getItemId()
	elseif itemA:getExpireTime() ~= itemB:getExpireTime() then
		return tonumber(itemA:getExpireTime()) > tonumber(itemB:getExpireTime())
	else
		return tonumber(itemA:getAddTime()) > tonumber(itemB:getAddTime())
	end
end

function isCharacterById(id)
	local mType, sType = getItemTypeByItemId(id)

	return mType == GameEnum.ItemTypeEnum.HeroType
end

function isCharacterSkinById(id)
	local mType, sType = getItemTypeByItemId(id)

	return mType == GameEnum.ItemTypeEnum.HeroSkin
end

function getItemCoIcon(itemCo)
	if isCharacterById(itemCo.id) then
		return CharacterCOUtil.getIcon(itemCo)
	end

	return itemCo.icon or ""
end

function parseCostStr(costStr)
	local temp = string.gsub(costStr, "{(.-)}", "%1")
	local itemInfo = string.split(temp, ":")

	if #itemInfo ~= 2 then
		return false
	end

	local itemId = tonumber(itemInfo[1])
	local number = tonumber(itemInfo[2])

	return itemId, number
end

function isEquipEchoOrD6ByItemId(itemId)
	local typ, _ = getItemTypeByItemId(itemId)

	return typ == GameEnum.ItemTypeEnum.EquipItemType or typ == GameEnum.ItemTypeEnum.EchoItemType or typ == GameEnum.ItemTypeEnum.DiceItem
end

function canStacked(itemId)
	local mainType, subType = getItemTypeByItemId(itemId)

	return mainType ~= GameEnum.ItemTypeEnum.EquipItemType and mainType ~= GameEnum.ItemTypeEnum.EchoItemType and mainType ~= GameEnum.ItemTypeEnum.DiceItem and mainType ~= GameEnum.ItemTypeEnum.HeroType and mainType ~= GameEnum.ItemTypeEnum.RoguelikeEquipType and mainType ~= GameEnum.ItemTypeEnum.RoguelikeClueType and mainType ~= GameEnum.ItemTypeEnum.FurnitureItemType
end

function canShowNumInGain(itemId)
	local mainType, subType = getItemTypeByItemId(itemId)

	return mainType ~= GameEnum.ItemTypeEnum.HeroSkin and mainType ~= GameEnum.ItemTypeEnum.EquipItemType and mainType ~= GameEnum.ItemTypeEnum.EchoItemType and mainType ~= GameEnum.ItemTypeEnum.ProtomerItemType and mainType ~= GameEnum.ItemTypeEnum.HeroType and mainType ~= GameEnum.ItemTypeEnum.DisplayCard and mainType ~= GameEnum.ItemTypeEnum.Portrait and mainType ~= GameEnum.ItemTypeEnum.DrawingItemType and mainType ~= GameEnum.ItemTypeEnum.DiceItem
end

function isItemEnough(itemId, needCount)
	local myCount = ItemModel.instance:getItemCountByItemId(itemId)

	return needCount <= myCount
end

function formatItemCount(num, n)
	local max = 999999

	if type(num) ~= "number" then
		return num
	end

	if num >= 0 and num <= max then
		return num
	end

	n = n or 1

	local formatNum = num / 10000

	if max < num then
		local isDecimal = formatNum > math.floor(formatNum)

		if isDecimal then
			formatNum = formatNum - formatNum % 0.1^n
		end
	end

	return string.format(lang("tip_count_format_unit"), formatNum)
end
