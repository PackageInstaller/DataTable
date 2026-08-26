-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_SaveInfoDetailBuffListItem.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_SaveInfoDetailBuffListItem", package.seeall)

local Rouge2_SaveInfoDetailBuffListItem = class("Rouge2_SaveInfoDetailBuffListItem", ListScrollCellExtend)

function Rouge2_SaveInfoDetailBuffListItem:onInitView()
	self._imageRare = gohelper.findChildImage(self.viewGO, "image_Rare")
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "image_Icon")
	self._txtName = gohelper.findChildText(self.viewGO, "txt_Name")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_SaveInfoDetailBuffListItem:addEvents()
	return
end

function Rouge2_SaveInfoDetailBuffListItem:removeEvents()
	return
end

function Rouge2_SaveInfoDetailBuffListItem:_editableInitView()
	return
end

function Rouge2_SaveInfoDetailBuffListItem:onUpdateMO(mo)
	self._mo = mo
	self._itemId = mo.itemId

	self:refreshUI()
end

function Rouge2_SaveInfoDetailBuffListItem:refreshUI()
	local itemCo = Rouge2_BackpackHelper.getItemConfig(self._itemId)

	self._txtName.text = itemCo and itemCo.name

	Rouge2_IconHelper.setItemIconAndRare(self._itemId, self._simageIcon, self._imageRare, Rouge2_Enum.ItemRareIconType.Default, Rouge2_Enum.ItemIconType.Type2)
end

function Rouge2_SaveInfoDetailBuffListItem:onSelect(isSelect)
	return
end

function Rouge2_SaveInfoDetailBuffListItem:onDestroyView()
	self._simageIcon:UnLoadImage()
end

return Rouge2_SaveInfoDetailBuffListItem
