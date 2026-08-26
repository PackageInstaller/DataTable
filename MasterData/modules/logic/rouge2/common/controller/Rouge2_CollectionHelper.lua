-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_CollectionHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_CollectionHelper", package.seeall)

local Rouge2_CollectionHelper = class("Rouge2_CollectionHelper")

function Rouge2_CollectionHelper.loadCollectionTags(collectionId, goTagParent, goTagItem)
	local tags = Rouge2_CollectionConfig.instance:getRelicsTagIds(collectionId) or {}

	gohelper.CreateObjList(nil, Rouge2_CollectionHelper._loadCollectionTagCallBack, tags, goTagParent, goTagItem)
end

function Rouge2_CollectionHelper._loadCollectionTagCallBack(callBackObj, tagObj, tagId, index)
	Rouge2_CollectionHelper._loadCollectionIconFunc(tagObj, tagId, index)

	local frameImg = gohelper.findChildImage(tagObj, "image_tagframe")

	UISpriteSetMgr.instance:setRougeSprite(frameImg, "rouge_collection_tagframe_1")
end

function Rouge2_CollectionHelper._loadCollectionIconFunc(tagObj, tagId, index)
	local tagImg = gohelper.findChildImage(tagObj, "image_tagicon")
	local tagCo = Rouge2_CollectionConfig.instance:getTagConfig(tagId)

	UISpriteSetMgr.instance:setRougeSprite(tagImg, tagCo and tagCo.iconUrl)
end

function Rouge2_CollectionHelper.checkCollectionHasAnyOneTag(collectionCfgId, enchantCfgId, baseTag, extraTag)
	if GameUtil.tabletool_dictIsEmpty(baseTag) and GameUtil.tabletool_dictIsEmpty(extraTag) then
		return true
	end

	local collectionTags, enchantTags = Rouge2_CollectionHelper.getCollectionAndEnchantTagIds(collectionCfgId, enchantCfgId)
	local totalTags = {}

	tabletool.addValues(totalTags, collectionTags)
	tabletool.addValues(totalTags, enchantTags)

	local isNeedCheckBaseTag = baseTag and tabletool.len(baseTag) > 0
	local isNeedCheckExtraTag = extraTag and tabletool.len(extraTag) > 0
	local isFitBaseTag = not isNeedCheckBaseTag

	if totalTags then
		for _, tag in ipairs(totalTags) do
			if isNeedCheckBaseTag and baseTag[tag] then
				isFitBaseTag = true
			end

			if isFitBaseTag and (isNeedCheckExtraTag and extraTag[tag] or nil) and true then
				return true
			end
		end
	end
end

function Rouge2_CollectionHelper.getCollectionAndEnchantTagIds(collectionCfgId, enchantCfgIds)
	local collectionTagIds = {}
	local enchantTagIds = {}
	local tagMap = {}
	local collectionCfg = Rouge2_OutSideConfig.getItemConfig(collectionCfgId)
	local collectiontags = {
		collectionCfg and collectionCfg.tag
	}
	local typeTag = Rouge2_BackpackHelper.itemId2Tag(collectionCfgId)

	table.insert(collectiontags, typeTag)
	Rouge2_CollectionHelper._getFilterCollectionTags(collectiontags, collectionTagIds, tagMap)

	if enchantCfgIds then
		for _, cfgId in ipairs(enchantCfgIds) do
			if cfgId > 0 then
				local enchantCfg = Rouge2_OutSideConfig.getItemConfig(cfgId)
				local tags = enchantCfg and enchantCfg.tags

				Rouge2_CollectionHelper._getFilterCollectionTags(tags, enchantTagIds, tagMap, true)
			end
		end
	end

	return collectionTagIds, enchantTagIds
end

function Rouge2_CollectionHelper._getFilterCollectionTags(tags, list, filterMap, isFilterTypeTag)
	if not tags then
		return
	end

	list = list or {}
	filterMap = filterMap or {}

	for _, tagId in ipairs(tags) do
		local isSatisfy = Rouge2_CollectionHelper._isCollectionTagSatisfy(tagId, filterMap, isFilterTypeTag)

		if isSatisfy then
			table.insert(list, tagId)

			filterMap[tagId] = true
		end
	end
end

function Rouge2_CollectionHelper._isCollectionTagSatisfy(tagId, filterMap, isFilterTypeTag)
	if not tagId or filterMap[tagId] then
		return false
	end

	if isFilterTypeTag then
		return tagId < Rouge2_OutsideEnum.MinCollectionExtraTagID
	end

	return true
end

function Rouge2_CollectionHelper.setItemIcon(imageComp, itemId)
	local bagType = Rouge2_BackpackHelper.itemId2Tag(itemId)

	if bagType == Rouge2_OutsideEnum.CollectionListType.AutoBuff then
		Rouge2_IconHelper.setActiveSkillIcon(itemId, imageComp)
	elseif bagType == Rouge2_OutsideEnum.CollectionListType.Buff then
		Rouge2_IconHelper.setBuffIcon(itemId, imageComp)
	elseif bagType == Rouge2_OutsideEnum.CollectionListType.Collection then
		Rouge2_IconHelper.setRelicsIcon(itemId, imageComp)
	else
		logError(string.format("Rouge2_BackpackHelper.getItemConfig 未定义背包类型, bagType = %s, itemId = %s", bagType, itemId))
	end
end

function Rouge2_CollectionHelper.setItemRareBg(imageComp, itemId)
	local bagType = Rouge2_BackpackHelper.itemId2Tag(itemId)

	if bagType == Rouge2_OutsideEnum.CollectionListType.AutoBuff then
		Rouge2_IconHelper.setBuffRareIcon(itemId, imageComp)
	elseif bagType == Rouge2_OutsideEnum.CollectionListType.Buff then
		Rouge2_IconHelper.setBuffRareIcon(itemId, imageComp)
	elseif bagType == Rouge2_OutsideEnum.CollectionListType.Collection then
		Rouge2_IconHelper.setRelicsRareIcon(itemId, imageComp)
	else
		logError(string.format("Rouge2_BackpackHelper.getItemConfig 未定义背包类型, bagType = %s, itemId = %s", bagType, itemId))
	end
end

return Rouge2_CollectionHelper
