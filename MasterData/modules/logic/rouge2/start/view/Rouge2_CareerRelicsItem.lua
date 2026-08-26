-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerRelicsItem.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerRelicsItem", package.seeall)

local Rouge2_CareerRelicsItem = class("Rouge2_CareerRelicsItem", LuaCompBase)

Rouge2_CareerRelicsItem.PercentColor = "#F3A055"
Rouge2_CareerRelicsItem.BracketColor = "#5E7DD9"
Rouge2_CareerRelicsItem.DescIncludeTypeList = {
	Rouge2_Enum.RelicsDescType.Desc
}

function Rouge2_CareerRelicsItem:init(go)
	self.go = go
	self._imagePropIcon = gohelper.findChildSingleImage(self.go, "#image_PropIcon")
	self._txtName = gohelper.findChildText(self.go, "#txt_Name")
	self._txtDescr = gohelper.findChildText(self.go, "#txt_Descr")
end

function Rouge2_CareerRelicsItem:onUpdateMO(careerId, relicsId)
	self._careerId = careerId
	self._relicsId = relicsId
	self._relicsCo = Rouge2_BackpackHelper.getItemConfig(relicsId)

	self:refreshUI()
	self:setUse(true)
end

function Rouge2_CareerRelicsItem:refreshUI()
	self._txtName.text = self._relicsCo and self._relicsCo.name

	Rouge2_IconHelper.setRelicsIcon(self._relicsId, self._imagePropIcon)
	Rouge2_ItemDescHelper.setItemDescStr(Rouge2_Enum.ItemDataType.Config, self._relicsId, self._txtDescr, Rouge2_Enum.ItemDescMode.Simply, Rouge2_CareerRelicsItem.DescIncludeTypeList, Rouge2_CareerRelicsItem.PercentColor, Rouge2_CareerRelicsItem.BracketColor)
end

function Rouge2_CareerRelicsItem:setUse(isUse)
	self._isUse = isUse

	gohelper.setActive(self.go, isUse)
end

function Rouge2_CareerRelicsItem:onDestory()
	return
end

return Rouge2_CareerRelicsItem
