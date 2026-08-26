-- chunkname: @modules/logic/rouge2/backpack/model/Rouge2_BackpackRelicsListModel.lua

module("modules.logic.rouge2.backpack.model.Rouge2_BackpackRelicsListModel", package.seeall)

local Rouge2_BackpackRelicsListModel = class("Rouge2_BackpackRelicsListModel", Rouge2_ItemListModelBase)
local ScrollMaxShowItemNum = 4

function Rouge2_BackpackRelicsListModel:_initTabIdList()
	local tabIdList = Rouge2_BackpackHelper.getItemSplitTypeList()

	table.insert(tabIdList, 1, Rouge2_Enum.BagItemTabId_All)

	return tabIdList
end

function Rouge2_BackpackRelicsListModel:_getItemTabIds(item)
	local attrTag = item:getAttrTag()

	return Rouge2_Enum.BagItemTabId_All, attrTag
end

function Rouge2_BackpackRelicsListModel._sortDefault(aItem, bItem)
	local aRare = aItem:getRare()
	local bRare = bItem:getRare()

	if aRare and bRare and aRare ~= bRare then
		return bRare < aRare
	end

	local aUid = aItem:getUid()
	local bUid = bItem:getUid()

	return bUid < aUid
end

function Rouge2_BackpackRelicsListModel:initList(itemList, selectTabId)
	self._canPlayOpenAnim = true

	local newItemList = self:_addFormulaItem(itemList)

	Rouge2_BackpackRelicsListModel.super.initList(self, newItemList, selectTabId)
end

function Rouge2_BackpackRelicsListModel:_addFormulaItem(itemList)
	local newItemList = {}

	tabletool.addValues(newItemList, itemList)

	local alchemyInfo = Rouge2_Model.instance:getCurAlchemyInfo()

	if alchemyInfo then
		local formulaId = alchemyInfo:getFormulaId()
		local formulaItem = Rouge2_BagItemMO.New()

		formulaItem._uid = -formulaId
		formulaItem.id = formulaItem._uid
		formulaItem._itemId = formulaId
		formulaItem._config = Rouge2_OutSideConfig.instance:getFormulaConfig(formulaId)
		formulaItem.alchemyInfo = alchemyInfo

		table.insert(newItemList, 1, formulaItem)
	end

	return newItemList
end

function Rouge2_BackpackRelicsListModel:getInfoList(scrollGO)
	self._mixCellInfo = {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(1, 481, nil)

		table.insert(self._mixCellInfo, mixCellInfo)
	end

	return self._mixCellInfo
end

function Rouge2_BackpackRelicsListModel:canPlayAinm(index)
	return index <= ScrollMaxShowItemNum and self._canPlayOpenAnim
end

function Rouge2_BackpackRelicsListModel:markPlayAnim()
	self._canPlayOpenAnim = false
end

Rouge2_BackpackRelicsListModel.instance = Rouge2_BackpackRelicsListModel.New()

return Rouge2_BackpackRelicsListModel
