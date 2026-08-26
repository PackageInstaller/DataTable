-- chunkname: @modules/logic/rouge2/backpack/model/Rouge2_BackpackBuffListModel.lua

module("modules.logic.rouge2.backpack.model.Rouge2_BackpackBuffListModel", package.seeall)

local Rouge2_BackpackBuffListModel = class("Rouge2_BackpackBuffListModel", Rouge2_ItemListModelBase)

function Rouge2_BackpackBuffListModel:_initTabIdList()
	local tabIdList = Rouge2_BackpackHelper.getItemSplitTypeList()

	table.insert(tabIdList, 1, Rouge2_Enum.BagItemTabId_All)

	return tabIdList
end

function Rouge2_BackpackBuffListModel:_getItemTabIds(item)
	local attrTag = item:getAttrTag()

	return Rouge2_Enum.BagItemTabId_All, attrTag
end

function Rouge2_BackpackBuffListModel._sortDefault(aItem, bItem)
	local aRare = aItem:getRare()
	local bRare = bItem:getRare()

	if aRare ~= bRare then
		return bRare < aRare
	end

	local aUid = aItem:getUid()
	local bUid = bItem:getUid()

	return bUid < aUid
end

Rouge2_BackpackBuffListModel.instance = Rouge2_BackpackBuffListModel.New()

return Rouge2_BackpackBuffListModel
