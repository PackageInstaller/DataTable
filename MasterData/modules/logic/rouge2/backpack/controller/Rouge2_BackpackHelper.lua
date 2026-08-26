-- chunkname: @modules/logic/rouge2/backpack/controller/Rouge2_BackpackHelper.lua

module("modules.logic.rouge2.backpack.controller.Rouge2_BackpackHelper", package.seeall)

local Rouge2_BackpackHelper = class("Rouge2_BackpackHelper")

function Rouge2_BackpackHelper.uid2BagType(uid)
	uid = tonumber(uid)

	if not uid then
		logError(string.format("Rouge2_BackpackHelper.uid2BagType error, uid = %s", uid))

		return
	end

	return math.floor(uid / 100000000)
end

function Rouge2_BackpackHelper.itemId2BagType(itemId)
	itemId = tonumber(itemId)

	if not itemId then
		logError(string.format("肉鸽构筑物id为空"))

		return
	end

	if itemId >= 100000 and itemId <= 199999 then
		return Rouge2_Enum.BagType.Relics
	elseif itemId >= 200000 and itemId <= 299999 then
		local buffCo = Rouge2_CollectionConfig.instance:getBuffConfig(itemId)

		if buffCo then
			if buffCo.isAttrBuff == 1 then
				return Rouge2_Enum.BagType.AttrBuff
			else
				return Rouge2_Enum.BagType.Buff
			end
		end
	elseif itemId >= 300000 and itemId <= 999999999 then
		return Rouge2_Enum.BagType.ActiveSkill
	else
		logError(string.format("肉鸽未定义构筑物类型 itemId = %s", itemId))
	end
end

function Rouge2_BackpackHelper.isBuff(dataType, dataId)
	local itemId, itemUid = Rouge2_BackpackHelper.getItemIdAndUid(dataType, dataId)
	local bagType = Rouge2_BackpackHelper.itemId2BagType(itemId)

	return bagType == Rouge2_Enum.BagType.Buff or bagType == Rouge2_Enum.BagType.AttrBuff
end

function Rouge2_BackpackHelper.itemId2Tag(itemId)
	itemId = tonumber(itemId)

	if not itemId then
		logError(string.format("Rouge2_BackpackHelper.itemId2Tag error, itemId = %s", itemId))

		return
	end

	if itemId >= 100000 and itemId <= 199999 then
		return Rouge2_OutsideEnum.CollectionListType.Collection
	elseif itemId >= 200000 and itemId <= 299999 then
		return Rouge2_OutsideEnum.CollectionListType.Buff
	elseif itemId >= 300000 and itemId <= 999999999 then
		return Rouge2_OutsideEnum.CollectionListType.AutoBuff
	else
		logError(string.format("肉鸽未定义构筑物类型 itemId = %s", itemId))
	end
end

function Rouge2_BackpackHelper.dropType2ItemDropViewName(dropType)
	if dropType == Rouge2_MapEnum.DropType.Buff then
		return ViewName.Rouge2_BuffDropView
	elseif dropType == Rouge2_MapEnum.DropType.Relics then
		return ViewName.Rouge2_RelicsDropView
	elseif dropType == Rouge2_MapEnum.DropType.ActiveSkill then
		return ViewName.Rouge2_ActiveSkillDropView
	elseif dropType == Rouge2_MapEnum.DropType.Coin then
		logNormal("肉鸽掉落金币")
	elseif dropType == Rouge2_MapEnum.DropType.RevivalCoin then
		logNormal("肉鸽掉落复活币")
	elseif dropType == Rouge2_MapEnum.DropType.AttrBuff then
		return ViewName.Rouge2_AttrBuffDropView
	else
		logError(string.format("肉鸽未定义掉落类型 dropType = " .. dropType))
	end
end

function Rouge2_BackpackHelper.itemType2ShowViewName(itemType)
	if itemType == Rouge2_Enum.BagType.Buff then
		return ViewName.Rouge2_BuffDropView
	elseif itemType == Rouge2_Enum.BagType.Relics then
		return ViewName.Rouge2_RelicsDropView
	elseif itemType == Rouge2_Enum.BagType.InVisibleRelics then
		logError("肉鸽掉落了隐藏造物!!!")

		return ViewName.Rouge2_RelicsDropView
	elseif itemType == Rouge2_Enum.BagType.ActiveSkill then
		return ViewName.Rouge2_ActiveSkillDropView
	elseif itemType == Rouge2_Enum.BagType.AttrBuff then
		return ViewName.Rouge2_AttrBuffDropView
	else
		logError(string.format("肉鸽未定义构筑物显示类型 itemType = " .. itemType))
	end
end

function Rouge2_BackpackHelper.getItemIdAndUid(dataType, dataId)
	local itemCo, itemMo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, dataId)
	local itemId = itemCo and itemCo.id
	local itemUid = itemMo and itemMo:getUid()

	return itemId, itemUid
end

function Rouge2_BackpackHelper.getItemCofigAndMo(dataType, dataId)
	local itemMo, itemCo

	if dataType == Rouge2_Enum.ItemDataType.Server then
		itemMo = Rouge2_BackpackModel.instance:getItem(dataId)
		itemCo = itemMo and itemMo:getConfig()
	elseif dataType == Rouge2_Enum.ItemDataType.Config then
		itemCo = Rouge2_BackpackHelper.getItemConfig(dataId)
	elseif dataType == Rouge2_Enum.ItemDataType.Clone then
		itemMo = dataId
		itemCo = dataId and itemMo:getConfig()
	else
		logError(string.format("未定义数据类型 dataType = %s, dataId = %s", dataType, dataId))
	end

	if not itemCo then
		logError(string.format("构筑物配置不存在 dataType = %s, dataId = %s", dataType, dataId))
	end

	return itemCo, itemMo
end

function Rouge2_BackpackHelper.getItemConfig(itemId)
	local bagType = Rouge2_BackpackHelper.itemId2BagType(itemId)
	local config

	if bagType == Rouge2_Enum.BagType.ActiveSkill then
		config = Rouge2_CollectionConfig.instance:getActiveSkillConfig(itemId)
	elseif bagType == Rouge2_Enum.BagType.Buff then
		config = Rouge2_CollectionConfig.instance:getBuffConfig(itemId)
	elseif bagType == Rouge2_Enum.BagType.Relics then
		config = Rouge2_CollectionConfig.instance:getRelicsConfig(itemId)
	elseif bagType == Rouge2_Enum.BagType.InVisibleRelics then
		logError(string.format("隐藏造物?? itemId = %s", itemId))

		config = Rouge2_CollectionConfig.instance:getRelicsConfig(itemId)
	elseif bagType == Rouge2_Enum.BagType.AttrBuff then
		config = Rouge2_CollectionConfig.instance:getBuffConfig(itemId)
	else
		logError(string.format("Rouge2_BackpackHelper.getItemConfig 未定义背包类型, bagType = %s, itemId = %s", bagType, itemId))
	end

	if not config then
		logError(string.format("肉鸽构筑物配置不存在 itemId = %s", itemId))
	end

	return config
end

function Rouge2_BackpackHelper.getItemNameList(dataType, itemList)
	local itemNameList = {}

	if itemList then
		for _, itemId in ipairs(itemList) do
			local itemCo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, itemId)

			if itemCo then
				table.insert(itemNameList, itemCo.name)
			end
		end
	end

	return itemNameList
end

function Rouge2_BackpackHelper.getItemSplitTypeList()
	local attrIdList = {}
	local attrInfoList = Rouge2_Model.instance:getHeroAttrInfoList()

	if attrInfoList then
		for _, attrInfo in ipairs(attrInfoList) do
			table.insert(attrIdList, attrInfo.attrId)
		end
	end

	return attrIdList
end

function Rouge2_BackpackHelper.setSkillUpdateAttrTips(dataType, dataId, goRoot, txtComp)
	local itemCo, itemMo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, dataId)
	local updateAttrList = Rouge2_CollectionConfig.instance:getSkillUpdateAttrList(itemCo.id)
	local hasUpdate = updateAttrList and #updateAttrList > 0

	gohelper.setActive(goRoot, hasUpdate)

	if not hasUpdate then
		return
	end

	local updateAttrStr = Rouge2_BackpackHelper._skillUpdateAttrList2Str(updateAttrList)

	txtComp.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_backpackskillview_attrupdatetips"), updateAttrStr)
end

function Rouge2_BackpackHelper._skillUpdateAttrList2Str(updateAttrList)
	local attrStrList = {}

	for _, updateCondition in ipairs(updateAttrList or {}) do
		local attrId = updateCondition[1]
		local attrValue = updateCondition[2]
		local attrSpriteIndex = Rouge2_AttributeConfig.instance:getAttrSpriteIndex(attrId)
		local curAttrValue = Rouge2_Model.instance:getAttrValue(attrId) or 0
		local isFit = attrValue <= curAttrValue
		local valueColor = isFit and "#FFFFFF" or "#C66030"
		local updateStr = string.format("<sprite=%s><%s>%s→%s</color>", attrSpriteIndex, valueColor, curAttrValue, attrValue)

		table.insert(attrStrList, updateStr)
	end

	return (table.concat(attrStrList, " "))
end

function Rouge2_BackpackHelper.filterItemList(itemList, filterTypeMap)
	local resultList = itemList or {}

	if filterTypeMap then
		for filterType, filterParamList in pairs(filterTypeMap) do
			for _, filterParam in ipairs(filterParamList) do
				resultList = Rouge2_BackpackHelper.filterItemListByOneType(resultList, filterType, filterParam)
			end
		end
	end

	return resultList
end

function Rouge2_BackpackHelper.filterItemListByOneType(itemList, filterType, filterParam)
	local resultList = {}

	if itemList then
		for _, item in ipairs(itemList) do
			local itemType = Rouge2_BackpackHelper.uid2BagType(item:getUid())
			local filterFunc = Rouge2_BackpackHelper.getFilterFunc(itemType, filterType)
			local itemCo = item:getConfig()

			if itemCo and filterFunc and filterFunc(item, itemCo, filterParam) then
				table.insert(resultList, item)
			end
		end
	end

	return resultList
end

function Rouge2_BackpackHelper.getFilterFunc(itemType, filterType)
	if not Rouge2_BackpackHelper._itemFilterFuncMap then
		Rouge2_BackpackHelper._itemFilterFuncMap = {}
		Rouge2_BackpackHelper._itemFilterFuncMap[Rouge2_Enum.BagType.Relics] = {
			[Rouge2_Enum.ItemFilterType.LessRare] = Rouge2_BackpackHelper._itemFilterFunc_LessRare,
			[Rouge2_Enum.ItemFilterType.LessAndEqualRare] = Rouge2_BackpackHelper._itemFilterFunc_LessAndEqualRare,
			[Rouge2_Enum.ItemFilterType.GreaterRare] = Rouge2_BackpackHelper._itemFilterFunc_GreaterRare,
			[Rouge2_Enum.ItemFilterType.GreaterAndEqualRare] = Rouge2_BackpackHelper._itemFilterFunc_GreaterAndEqualRare,
			[Rouge2_Enum.ItemFilterType.EqualRare] = Rouge2_BackpackHelper._itemFilterFunc_EqualRare,
			[Rouge2_Enum.ItemFilterType.Attribute] = Rouge2_BackpackHelper._itemFilterFunc_Attribute,
			[Rouge2_Enum.ItemFilterType.Unique] = Rouge2_BackpackHelper._itemFilterFunc_Unique,
			[Rouge2_Enum.ItemFilterType.Remove] = Rouge2_BackpackHelper._itemFilterFunc_Remove
		}
		Rouge2_BackpackHelper._itemFilterFuncMap[Rouge2_Enum.BagType.Buff] = {
			[Rouge2_Enum.ItemFilterType.LessRare] = Rouge2_BackpackHelper._itemFilterFunc_LessRare,
			[Rouge2_Enum.ItemFilterType.LessAndEqualRare] = Rouge2_BackpackHelper._itemFilterFunc_LessAndEqualRare,
			[Rouge2_Enum.ItemFilterType.GreaterRare] = Rouge2_BackpackHelper._itemFilterFunc_GreaterRare,
			[Rouge2_Enum.ItemFilterType.GreaterAndEqualRare] = Rouge2_BackpackHelper._itemFilterFunc_GreaterAndEqualRare,
			[Rouge2_Enum.ItemFilterType.EqualRare] = Rouge2_BackpackHelper._itemFilterFunc_EqualRare,
			[Rouge2_Enum.ItemFilterType.Attribute] = Rouge2_BackpackHelper._itemFilterFunc_Attribute,
			[Rouge2_Enum.ItemFilterType.Unique] = Rouge2_BackpackHelper._itemFilterFunc_Unique,
			[Rouge2_Enum.ItemFilterType.Remove] = Rouge2_BackpackHelper._itemFilterFunc_Remove
		}
		Rouge2_BackpackHelper._itemFilterFuncMap[Rouge2_Enum.BagType.AttrBuff] = Rouge2_BackpackHelper._itemFilterFuncMap[Rouge2_Enum.BagType.Buff]
	end

	local funcMap = Rouge2_BackpackHelper._itemFilterFuncMap[itemType]
	local filterFunc = funcMap and funcMap[filterType]

	if not filterFunc then
		logError(string.format("肉鸽缺少构筑物筛选方法 itemType = %s, filterType = %s", itemType, filterType))
	end

	return filterFunc
end

function Rouge2_BackpackHelper._itemFilterFunc_LessRare(itemMo, itemCo, param)
	return itemCo.rare < tonumber(param)
end

function Rouge2_BackpackHelper._itemFilterFunc_LessAndEqualRare(itemMo, itemCo, param)
	return itemCo.rare <= tonumber(param)
end

function Rouge2_BackpackHelper._itemFilterFunc_GreaterRare(itemMo, itemCo, param)
	return itemCo.rare > tonumber(param)
end

function Rouge2_BackpackHelper._itemFilterFunc_GreaterAndEqualRare(itemMo, itemCo, param)
	return itemCo.rare >= tonumber(param)
end

function Rouge2_BackpackHelper._itemFilterFunc_EqualRare(itemMo, itemCo, param)
	return itemCo.rare == tonumber(param)
end

function Rouge2_BackpackHelper._itemFilterFunc_Attribute(itemMo, itemCo, param)
	return itemCo.attributeTag == tostring(param)
end

function Rouge2_BackpackHelper._itemFilterFunc_Unique(itemMo, itemCo, isUnique)
	if isUnique then
		return itemCo.isUnique ~= 0
	else
		return itemCo.isUnique == 0
	end
end

function Rouge2_BackpackHelper._itemFilterFunc_Remove(itemMo, itemCo, isRemove)
	local itemId = itemCo and itemCo.id
	local isUnRemove = Rouge2_MapConfig.instance:isRelicsUnRemove(itemId)

	if isRemove then
		return not isUnRemove
	end

	return true
end

return Rouge2_BackpackHelper
