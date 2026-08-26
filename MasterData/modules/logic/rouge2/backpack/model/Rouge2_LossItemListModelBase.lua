-- chunkname: @modules/logic/rouge2/backpack/model/Rouge2_LossItemListModelBase.lua

module("modules.logic.rouge2.backpack.model.Rouge2_LossItemListModelBase", package.seeall)

local Rouge2_LossItemListModelBase = class("Rouge2_LossItemListModelBase", Rouge2_ItemListModelBase)

function Rouge2_LossItemListModelBase:setLossType(type)
	self._lossType = type
end

function Rouge2_LossItemListModelBase:getLossType()
	return self._lossType
end

function Rouge2_LossItemListModelBase:initList(maxSelectCount, itemList, selectTabId)
	Rouge2_LossItemListModelBase.super.initList(self, itemList, selectTabId)

	self._selectCount = 0
	self._selectItemMap = {}
	self._selectItemList = {}
	self._maxSelectCount = maxSelectCount
end

function Rouge2_LossItemListModelBase:_initTabIdList()
	local tabIdList = Rouge2_BackpackHelper.getItemSplitTypeList()

	table.insert(tabIdList, 1, Rouge2_Enum.BagItemTabId_All)

	return tabIdList
end

function Rouge2_LossItemListModelBase:_getItemTabIds(item)
	local attrTag = item:getAttrTag()

	return Rouge2_Enum.BagItemTabId_All, attrTag
end

function Rouge2_LossItemListModelBase._sortDefault(aItem, bItem)
	local aRare = aItem:getRare()
	local bRare = bItem:getRare()

	if aRare ~= bRare then
		return bRare < aRare
	end

	local aUid = aItem:getUid()
	local bUid = bItem:getUid()

	return bUid < aUid
end

function Rouge2_LossItemListModelBase:getSelectItemList()
	return self._selectItemList
end

function Rouge2_LossItemListModelBase:checkCanSelect()
	return self._selectCount < self._maxSelectCount
end

function Rouge2_LossItemListModelBase:getSelectCount()
	return self._selectCount
end

function Rouge2_LossItemListModelBase:getMaxSelectCount()
	return self._maxSelectCount
end

function Rouge2_LossItemListModelBase:getSelectCountByAttr(attrId)
	if attrId == Rouge2_Enum.BagItemTabId_All then
		return self:getSelectCount()
	end

	local attrSelectNum = 0
	local selectItemList = self:getSelectItemList()

	if selectItemList then
		for _, itemMo in ipairs(selectItemList) do
			local attrTag = itemMo:getAttrTag()

			if attrTag == attrId then
				attrSelectNum = attrSelectNum + 1
			end
		end
	end

	return attrSelectNum
end

function Rouge2_LossItemListModelBase:selectMo(mo)
	if self._selectCount >= self._maxSelectCount then
		return
	end

	if mo and self._selectItemMap[mo] then
		return
	end

	self._selectItemMap[mo] = true

	table.insert(self._selectItemList, mo)

	self._selectCount = self._selectCount + 1

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectLossItemChange)
end

function Rouge2_LossItemListModelBase:deselectMo(mo)
	if mo and self._selectItemMap[mo] then
		self._selectCount = self._selectCount - 1
		self._selectItemMap[mo] = nil

		tabletool.removeValue(self._selectItemList, mo)
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectLossItemChange)
	end
end

function Rouge2_LossItemListModelBase:isSelect(mo)
	local var_14_0

	if mo then
		::label_14_0::

		var_14_0 = self._selectItemMap and self._selectItemMap[mo] == true
	end

	return var_14_0
end

Rouge2_LossItemListModelBase.instance = Rouge2_LossItemListModelBase.New()

return Rouge2_LossItemListModelBase
