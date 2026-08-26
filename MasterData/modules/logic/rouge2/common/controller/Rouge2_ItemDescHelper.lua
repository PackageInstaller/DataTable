-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_ItemDescHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_ItemDescHelper", package.seeall)

local Rouge2_ItemDescHelper = class("Rouge2_ItemDescHelper")

function Rouge2_ItemDescHelper._buildDescMo(descType, descMode, ...)
	local mo = Rouge2_ItemDescInfoMO.New()

	mo:init(descType, descMode, ...)

	return mo
end

function Rouge2_ItemDescHelper._addDescMo(moList, mo)
	if not mo then
		return
	end

	table.insert(moList, mo)
end

function Rouge2_ItemDescHelper.getItemDescHelper(dataType, dataId)
	local itemId, uid = Rouge2_BackpackHelper.getItemIdAndUid(dataType, dataId)
	local itemType = Rouge2_BackpackHelper.itemId2BagType(itemId)

	if not itemType then
		return
	end

	Rouge2_ItemDescHelper._itemType2HelperMap = Rouge2_ItemDescHelper._itemType2HelperMap or {}

	local helper = Rouge2_ItemDescHelper._itemType2HelperMap[itemType]

	if not helper then
		local helperCls = Rouge2_Enum.ItemType2DescHelper[itemType]

		helper = helperCls and helperCls.New()
		Rouge2_ItemDescHelper._itemType2HelperMap[itemType] = helper
	end

	if not helper then
		logError(string.format("Rouge2_ItemDescHelper.getItemDescHelper error helper is nil ! dataType = %s, dataId = %s, itemId = %s, itemType = %s", dataType, dataId, itemId, itemType))
	end

	return helper
end

function Rouge2_ItemDescHelper.getDefaultIncludeTypeList(dataType, dataId)
	local helper = Rouge2_ItemDescHelper.getItemDescHelper(dataType, dataId)

	return helper and helper:getDefaultIncludeTypeList()
end

function Rouge2_ItemDescHelper.getItemDescList(dataType, dataId, descMode, includeTypeList)
	local helper = Rouge2_ItemDescHelper.getItemDescHelper(dataType, dataId)

	if not helper then
		return {}
	end

	return helper:getItemDescList(dataType, dataId, descMode, includeTypeList)
end

function Rouge2_ItemDescHelper.setItemDesc(dataType, dataId, goParent, descMode, includeTypeList)
	local helper = Rouge2_ItemDescHelper.getItemDescHelper(dataType, dataId)

	return helper and helper:setItemDesc(dataType, dataId, goParent, descMode, includeTypeList)
end

function Rouge2_ItemDescHelper.getItemDescStr(dataType, dataId, descMode, includeTypeList)
	local helper = Rouge2_ItemDescHelper.getItemDescHelper(dataType, dataId)

	return helper and helper:getItemDescStr(dataType, dataId, descMode, includeTypeList) or ""
end

function Rouge2_ItemDescHelper.setItemDescStr(dataType, dataId, txtComp, descMode, includeTypeList, percentColor, bracketColor)
	local descStr = Rouge2_ItemDescHelper.getItemDescStr(dataType, dataId, descMode, includeTypeList)

	Rouge2_ItemDescHelper.buildAndSetDesc(txtComp, descStr, percentColor, bracketColor)
end

function Rouge2_ItemDescHelper.buildDesc(desc, percentColor, bracketColor)
	if string.nilorempty(desc) then
		return desc
	end

	percentColor = percentColor or "#b84E32"
	desc = Rouge2_ItemDescLinkHelper.addLink(desc)

	return SkillHelper.addColor(desc, percentColor, bracketColor)
end

function Rouge2_ItemDescHelper.replaceColor(str, originColor, targetColor)
	return string.gsub(str, originColor, targetColor)
end

function Rouge2_ItemDescHelper.buildAndSetDesc(txtComp, desc, percentColor, bracketColor)
	txtComp.text = Rouge2_ItemDescHelper.buildDesc(desc, percentColor, bracketColor)

	SkillHelper.addHyperLinkClick(txtComp)
	Rouge2_ItemDescSpriteLoader.Get(txtComp)
	Rouge2_ItemDescHelper.addFixTmpBreakLine(txtComp)
end

function Rouge2_ItemDescHelper.addFixTmpBreakLine(txtComp)
	if not txtComp then
		return
	end

	local fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(txtComp.gameObject, FixTmpBreakLine)

	fixTmpBreakLine:refreshTmpContent(txtComp)

	return fixTmpBreakLine
end

return Rouge2_ItemDescHelper
