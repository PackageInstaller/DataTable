-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_SaveInfoDetailAttrBuffListItem.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_SaveInfoDetailAttrBuffListItem", package.seeall)

local Rouge2_SaveInfoDetailAttrBuffListItem = class("Rouge2_SaveInfoDetailAttrBuffListItem", ListScrollCellExtend)

function Rouge2_SaveInfoDetailAttrBuffListItem:onInitView()
	self._imageBg = gohelper.findChildImage(self.viewGO, "image_Bg")
	self._imageRare = gohelper.findChildImage(self.viewGO, "image_Rare")
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "image_Icon")
	self._txtName = gohelper.findChildText(self.viewGO, "txt_Name")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_SaveInfoDetailAttrBuffListItem:addEvents()
	return
end

function Rouge2_SaveInfoDetailAttrBuffListItem:removeEvents()
	return
end

function Rouge2_SaveInfoDetailAttrBuffListItem:_editableInitView()
	return
end

function Rouge2_SaveInfoDetailAttrBuffListItem:onUpdateMO(mo)
	self._mo = mo
	self._itemId = mo.itemId

	self:refreshUI()
end

function Rouge2_SaveInfoDetailAttrBuffListItem:refreshUI()
	local itemCo = Rouge2_OutSideConfig.getItemConfig(self._itemId)

	self._txtName.text = itemCo and itemCo.name

	Rouge2_IconHelper.setGameItemRare(self._itemId, self._imageBg, Rouge2_Enum.ItemRareIconType.CircleBg)
	Rouge2_IconHelper.setItemIconAndRare(self._itemId, self._simageIcon, self._imageRare)
end

function Rouge2_SaveInfoDetailAttrBuffListItem:onSelect(isSelect)
	return
end

function Rouge2_SaveInfoDetailAttrBuffListItem:onDestroyView()
	self._simageIcon:UnLoadImage()
end

return Rouge2_SaveInfoDetailAttrBuffListItem
